import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/logic/magic_link_uri.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/usecases/complete_magic_link.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/usecases/ensure_user_profile.dart';

@lazySingleton
class MagicLinkDeepLinkListener {
  MagicLinkDeepLinkListener(
    this._completeMagicLinkUseCase,
    this._ensureUserProfile,
    this._appLinks,
    this._firebaseAuth,
    this._logger,
  );

  final CompleteMagicLinkUseCase _completeMagicLinkUseCase;
  final EnsureUserProfile _ensureUserProfile;
  final AppLinks _appLinks;
  final FirebaseAuth _firebaseAuth;
  final Logger _logger;

  final StreamController<String> _errorsController =
      StreamController<String>.broadcast();

  StreamSubscription<Uri>? _subscription;
  bool _handling = false;

  /// Failures from deep-link completion (for auth UI).
  Stream<String> get errors => _errorsController.stream;

  Future<void> start() async {
    if (_subscription != null) return;

    try {
      final initial = await _appLinks.getInitialLink();
      if (initial != null) {
        await handleUri(initial);
      }
    } catch (error, stackTrace) {
      _logger.w(
        'Magic link: failed to read initial link',
        error: error,
        stackTrace: stackTrace,
      );
    }

    _subscription = _appLinks.uriLinkStream.listen(
      handleUri,
      onError: (Object error, StackTrace stackTrace) {
        _logger.w(
          'Magic link: uri stream error',
          error: error,
          stackTrace: stackTrace,
        );
      },
    );
  }

  Future<void> handleUri(Uri uri) async {
    final candidates = <String>[
      ?resolveMagicLinkEmailLink(uri),
      uri.toString(),
      ?uri.queryParameters['link'],
    ];

    String? emailLink;
    for (final candidate in candidates) {
      if (_firebaseAuth.isSignInWithEmailLink(candidate)) {
        emailLink = candidate;
        break;
      }
    }
    if (emailLink == null) {
      _logger.w('Magic link: URI is not a sign-in email link: $uri');
      return;
    }
    if (_handling) return;
    _handling = true;
    try {
      final result = await _completeMagicLinkUseCase(
        CompleteMagicLinkParams(emailLink: emailLink),
      );
      await result.fold(
        (error) async {
          _logger.w('Magic link complete failed: $error');
          if (!_errorsController.isClosed) {
            _errorsController.add(error);
          }
        },
        (_) async {
          final user = _firebaseAuth.currentUser;
          if (user == null) return;
          await _ensureUserProfile(
            EnsureUserProfileParams(
              uid: user.uid,
              displayName: user.displayName ?? '',
              email: user.email ?? '',
            ),
          );
        },
      );
    } catch (error, stackTrace) {
      _logger.w(
        'Magic link: unexpected complete error',
        error: error,
        stackTrace: stackTrace,
      );
      if (!_errorsController.isClosed) {
        _errorsController.add(
          'There was a problem signing in with the email link.',
        );
      }
    } finally {
      _handling = false;
    }
  }

  Future<void> dispose() async {
    await _subscription?.cancel();
    _subscription = null;
    await _errorsController.close();
  }
}

import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/exceptions/auth_exception.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/handle_magic_link.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/watch_incoming_links.dart';

/// Completes email-link sign-in for links the app is opened with.
///
/// Runs for the whole app lifetime; the sign-in screen shows its [errors].
@lazySingleton
class MagicLinkListener {
  MagicLinkListener(
    this._watchIncomingLinks,
    this._handleMagicLink,
    this._logger,
  );

  final WatchIncomingLinks _watchIncomingLinks;
  final HandleMagicLink _handleMagicLink;
  final Logger _logger;

  final _errors = StreamController<String>.broadcast();
  StreamSubscription<Uri>? _subscription;
  bool _handling = false;

  /// User-facing failures of deep-link sign-in.
  Stream<String> get errors => _errors.stream;

  void start() => _subscription ??= _watchIncomingLinks().listen(_handle);

  Future<void> _handle(Uri uri) async {
    if (_handling) return;
    _handling = true;
    try {
      // The URI may contain a one-time sign-in code, so it is never logged.
      if (!await _handleMagicLink(uri)) {
        _logger.d(
          'Magic link: ignoring a deep link that is not a sign-in link',
        );
      }
    } on AuthException catch (error, stackTrace) {
      _logger.w(
        'Magic link: sign-in failed',
        error: error,
        stackTrace: stackTrace,
      );
      if (!_errors.isClosed) _errors.add(error.message);
    } finally {
      _handling = false;
    }
  }

  @disposeMethod
  Future<void> dispose() async {
    await _subscription?.cancel();
    _subscription = null;
    await _errors.close();
  }
}

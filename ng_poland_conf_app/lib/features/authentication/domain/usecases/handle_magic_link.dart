import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/domain/use_case.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/services/magic_link_uri.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/usecases/complete_magic_link.dart';

/// Completes sign-in when [Uri] carries a Firebase email link.
///
/// Returns `false` for unrelated deep links.
@injectable
class HandleMagicLink implements UseCase<bool, Uri> {
  const HandleMagicLink(this._authentication, this._completeMagicLink);

  final AuthenticationRepository _authentication;
  final CompleteMagicLink _completeMagicLink;

  @override
  Future<bool> call(Uri uri) async {
    final emailLink = [
      ?resolveMagicLinkEmailLink(uri),
      uri.toString(),
      ?uri.queryParameters['link'],
    ].firstWhereOrNull(_authentication.isSignInLink);
    if (emailLink == null) return false;

    await _completeMagicLink(CompleteMagicLinkParams(emailLink: emailLink));
    return true;
  }
}

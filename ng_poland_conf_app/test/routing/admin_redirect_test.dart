import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/admin_page.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_role.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/cubit/user_session_cubit.dart';
import 'package:ng_poland_conf_app/routing/routing.dart';

void main() {
  const adminProfile = UserProfile(
    uid: 'u1',
    displayName: 'Ada',
    email: 'ada@example.com',
    role: UserRole.admin,
  );
  const userProfile = UserProfile(
    uid: 'u1',
    displayName: 'Ada',
    email: 'ada@example.com',
    role: UserRole.user,
  );

  test('does not redirect /admin while session is loading', () {
    expect(
      adminGuardRedirect(
        matchedLocation: AdminPage.path,
        session: const UserSessionState.loading(),
      ),
      isNull,
    );
  });

  test('sends non-admin away from /admin after session settles', () {
    expect(
      adminGuardRedirect(
        matchedLocation: AdminPage.path,
        session: const UserSessionState.unauthenticated(),
      ),
      Pages.home.path,
    );
    expect(
      adminGuardRedirect(
        matchedLocation: AdminPage.path,
        session: const UserSessionState.authenticated(userProfile),
      ),
      Pages.home.path,
    );
  });

  test('allows authenticated admin to stay on /admin', () {
    expect(
      adminGuardRedirect(
        matchedLocation: AdminPage.path,
        session: const UserSessionState.authenticated(adminProfile),
      ),
      isNull,
    );
  });
}

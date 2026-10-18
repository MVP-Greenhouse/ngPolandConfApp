import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/app/routing/redirects.dart';
import 'package:ng_poland_conf_app/core/presentation/navigation/app_pages.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_role.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/entities/user_session.dart';

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
        matchedLocation: AppPaths.admin,
        session: const UserSession.loading(),
      ),
      isNull,
    );
  });

  test('sends non-admin away from /admin after session settles', () {
    expect(
      adminGuardRedirect(
        matchedLocation: AppPaths.admin,
        session: const UserSession.signedOut(),
      ),
      Pages.home.path,
    );
    expect(
      adminGuardRedirect(
        matchedLocation: AppPaths.admin,
        session: const UserSession.signedIn(userProfile),
      ),
      Pages.home.path,
    );
  });

  test('guards nested admin paths', () {
    expect(
      adminGuardRedirect(
        matchedLocation: '/admin/voting',
        session: const UserSession.signedIn(userProfile),
      ),
      Pages.home.path,
    );
    expect(
      adminGuardRedirect(
        matchedLocation: '/admin/contest',
        session: const UserSession.signedOut(),
      ),
      Pages.home.path,
    );
  });

  test('allows authenticated admin to stay on /admin', () {
    expect(
      adminGuardRedirect(
        matchedLocation: AppPaths.admin,
        session: const UserSession.signedIn(adminProfile),
      ),
      isNull,
    );
  });

  test('allows authenticated admin to stay on nested admin paths', () {
    expect(
      adminGuardRedirect(
        matchedLocation: '/admin/voting',
        session: const UserSession.signedIn(adminProfile),
      ),
      isNull,
    );
  });
}

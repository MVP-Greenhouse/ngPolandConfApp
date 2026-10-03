import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/authentication_page.dart';
import 'package:ng_poland_conf_app/routing/routing.dart';

void main() {
  test('guest can browse home without redirect', () {
    expect(
      authRedirect(
        matchedLocation: Pages.home.path,
        fullPath: Pages.home.path,
        queryParameters: const {},
        isAuthenticated: false,
      ),
      isNull,
    );
  });

  test('guest can browse schedule without redirect', () {
    expect(
      authRedirect(
        matchedLocation: Pages.schedule.path,
        fullPath: Pages.schedule.path,
        queryParameters: const {},
        isAuthenticated: false,
      ),
      isNull,
    );
  });

  test('guest on /auth stays (no redirect)', () {
    expect(
      authRedirect(
        matchedLocation: AuthenticationPage.path,
        fullPath: AuthenticationPage.path,
        queryParameters: const {},
        isAuthenticated: false,
      ),
      isNull,
    );
  });

  test('authenticated on /auth without from goes home', () {
    expect(
      authRedirect(
        matchedLocation: AuthenticationPage.path,
        fullPath: AuthenticationPage.path,
        queryParameters: const {},
        isAuthenticated: true,
      ),
      Pages.home.path,
    );
  });

  test('authenticated on /auth with from returns from', () {
    expect(
      authRedirect(
        matchedLocation: AuthenticationPage.path,
        fullPath: AuthenticationPage.path,
        queryParameters: const {'from': '/schedule/top5'},
        isAuthenticated: true,
      ),
      '/schedule/top5',
    );
  });

  test('authenticated on home has no redirect', () {
    expect(
      authRedirect(
        matchedLocation: Pages.home.path,
        fullPath: Pages.home.path,
        queryParameters: const {},
        isAuthenticated: true,
      ),
      isNull,
    );
  });
}

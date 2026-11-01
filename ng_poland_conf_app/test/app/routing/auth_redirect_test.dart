import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/app/routing/redirects.dart';
import 'package:ng_poland_conf_app/core/presentation/navigation/app_pages.dart';
import 'package:ng_poland_conf_app/core/presentation/navigation/redirect_paths.dart';

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
        matchedLocation: AppPaths.auth,
        fullPath: AppPaths.auth,
        queryParameters: const {},
        isAuthenticated: false,
      ),
      isNull,
    );
  });

  test('authenticated on /auth without from goes home', () {
    expect(
      authRedirect(
        matchedLocation: AppPaths.auth,
        fullPath: AppPaths.auth,
        queryParameters: const {},
        isAuthenticated: true,
      ),
      Pages.home.path,
    );
  });

  test('authenticated on /auth with from returns from', () {
    expect(
      authRedirect(
        matchedLocation: AppPaths.auth,
        fullPath: AppPaths.auth,
        queryParameters: const {'from': '/schedule/top5'},
        isAuthenticated: true,
      ),
      '/schedule/top5',
    );
  });

  test('authenticated on /auth rejects absolute from and goes home', () {
    expect(
      authRedirect(
        matchedLocation: AppPaths.auth,
        fullPath: AppPaths.auth,
        queryParameters: const {'from': 'https://evil.example/phish'},
        isAuthenticated: true,
      ),
      Pages.home.path,
    );
  });

  test('authenticated on /auth rejects protocol-relative from', () {
    expect(
      authRedirect(
        matchedLocation: AppPaths.auth,
        fullPath: AppPaths.auth,
        queryParameters: const {'from': '//evil.example/phish'},
        isAuthenticated: true,
      ),
      Pages.home.path,
    );
  });

  test('authenticated on /auth rejects from=/auth loop', () {
    expect(
      authRedirect(
        matchedLocation: AppPaths.auth,
        fullPath: AppPaths.auth,
        queryParameters: const {'from': '/auth'},
        isAuthenticated: true,
      ),
      Pages.home.path,
    );
  });

  test('safeInternalRedirectPath keeps query', () {
    expect(
      safeInternalRedirectPath('/schedule?track=ngPoland'),
      '/schedule?track=ngPoland',
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

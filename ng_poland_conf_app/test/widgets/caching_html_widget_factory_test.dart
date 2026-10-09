import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/widgets/app_image_cache.dart';
import 'package:ng_poland_conf_app/widgets/caching_html_widget_factory.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const pathProvider = MethodChannel('plugins.flutter.io/path_provider');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(pathProvider, (call) async => '.');

  test('html images use the same disk cache as speaker photos', () {
    final provider = CachingHtmlWidgetFactory().imageProviderFromNetwork(
      'https://images.example/speaker.jpg',
    );

    expect(provider, isA<CachedNetworkImageProvider>());
    final cached = provider! as CachedNetworkImageProvider;
    expect(cached.cacheManager, same(AppImageCache.instance));
  });
}

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/app/di/injectable.config.dart';

/// Service locator. Only the composition root (`main.dart`, `lib/app/`)
/// resolves dependencies from it; everything else gets them injected.
final getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: true)
Future<void> configureDependencies(String environment) =>
    getIt.init(environment: environment);

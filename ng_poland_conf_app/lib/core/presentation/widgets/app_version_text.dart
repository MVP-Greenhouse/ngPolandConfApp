import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Shows [prefix] and the installed version, for example `1.4.0 (16)`, once
/// it's known.
class AppVersionText extends HookWidget {
  const AppVersionText({super.key, required this.prefix, required this.style});

  final String prefix;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final info = useFuture(useMemoized(PackageInfo.fromPlatform)).data;
    return Text(
      info == null ? '' : '$prefix${info.version} (${info.buildNumber})',
      style: style,
    );
  }
}

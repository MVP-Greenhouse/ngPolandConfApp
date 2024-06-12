import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/core/blocks/themeMode/theme_mode_cubit.dart';

class IconWithDarkMode extends StatelessWidget {
  final String imageName;
  final double? width;
  final double? height;

  const IconWithDarkMode({
    super.key,
    required this.imageName,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage('assets/icons/${isDarkMode ? 'dark' : 'light'}/$imageName'),
      width: width,
      height: height,
    );
  }
}

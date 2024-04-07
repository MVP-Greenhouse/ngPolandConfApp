import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/core/blocks/themeMode/theme_mode_cubit.dart';

class ImageWithDarkMode extends StatelessWidget {
  final String imageName;
  final double? width;
  final double? height;

  const ImageWithDarkMode({
    super.key,
    required this.imageName,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage('assets/images/${isDarkMode ? 'dark' : 'light'}/$imageName'),
      width: width,
      height: height,
    );
  }
}

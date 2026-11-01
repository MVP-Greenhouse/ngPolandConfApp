import 'package:flutter/material.dart';

/// Asset icon with separate light and dark variants.
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
    final variant = Theme.of(context).brightness == .dark ? 'dark' : 'light';
    return Image(
      image: AssetImage('assets/icons/$variant/$imageName'),
      width: width,
      height: height,
    );
  }
}

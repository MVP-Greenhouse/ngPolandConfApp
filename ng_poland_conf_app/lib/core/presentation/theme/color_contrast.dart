import 'package:flutter/material.dart';

/// Backgrounds brighter than this get dark text for readable contrast.
const lightBackgroundLuminance = 0.55;

extension ColorContrast on Color {
  /// Black or white, whichever reads better on this colour.
  Color get readableForeground => computeLuminance() > lightBackgroundLuminance
      ? Colors.black
      : Colors.white;
}

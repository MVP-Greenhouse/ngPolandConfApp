import 'package:flutter/material.dart';

/// Shared Stitch-aligned surfaces for the auth screen (readable over photo bg).
abstract final class AuthUiTokens {
  static const cardBg = Color(0xE61A1B1E);
  static const fieldBg = Color(0xFF2C2D32);
  static const fieldBorder = Color(0xFF4A4B52);
  static const chipBg = Color(0xF22C2D32);

  static List<BoxShadow> cardShadow(Color accent) => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.45),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: accent.withValues(alpha: 0.12),
          blurRadius: 28,
          spreadRadius: -2,
        ),
      ];
}

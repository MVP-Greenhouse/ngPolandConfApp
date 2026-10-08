import 'package:flutter/material.dart';

class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.screen,
    required this.card,
    required this.panel,
    required this.muted,
    required this.accent,
    required this.onCard,
    required this.onAccent,
    required this.hairline,
    required this.chip,
    required this.onChip,
  });

  final Color screen;
  final Color card;
  final Color panel;
  final Color muted;
  final Color accent;
  final Color onCard;
  final Color onAccent;
  final Color hairline;
  final Color chip;
  final Color onChip;

  static const light = AppPalette(
    screen: Color(0xFFF7F4FA),
    card: Color(0xFFFFFFFF),
    panel: Color(0xFFF3EEF6),
    muted: Color(0xFF6B5A78),
    accent: Color(0xFFFF2D87),
    onCard: Color(0xFF1A1024),
    onAccent: Color(0xFFFFFFFF),
    hairline: Color(0x1F000000),
    chip: Color(0xFFEDE4F7),
    onChip: Color(0xFF4A148C),
  );

  static const dark = AppPalette(
    screen: Color(0xFF120C18),
    card: Color(0xFF1C1228),
    panel: Color(0xFF24182F),
    muted: Color(0xFFB9A8C4),
    accent: Color(0xFFFF2D87),
    onCard: Color(0xFFFFFFFF),
    onAccent: Color(0xFFFFFFFF),
    hairline: Color(0x24FFFFFF),
    chip: Color(0xFF3B2468),
    onChip: Color(0xFFE4D4FF),
  );

  @override
  AppPalette copyWith({
    Color? screen,
    Color? card,
    Color? panel,
    Color? muted,
    Color? accent,
    Color? onCard,
    Color? onAccent,
    Color? hairline,
    Color? chip,
    Color? onChip,
  }) {
    return AppPalette(
      screen: screen ?? this.screen,
      card: card ?? this.card,
      panel: panel ?? this.panel,
      muted: muted ?? this.muted,
      accent: accent ?? this.accent,
      onCard: onCard ?? this.onCard,
      onAccent: onAccent ?? this.onAccent,
      hairline: hairline ?? this.hairline,
      chip: chip ?? this.chip,
      onChip: onChip ?? this.onChip,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    return AppPalette(
      screen: Color.lerp(screen, other.screen, t)!,
      card: Color.lerp(card, other.card, t)!,
      panel: Color.lerp(panel, other.panel, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      onCard: Color.lerp(onCard, other.onCard, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      hairline: Color.lerp(hairline, other.hairline, t)!,
      chip: Color.lerp(chip, other.chip, t)!,
      onChip: Color.lerp(onChip, other.onChip, t)!,
    );
  }
}

extension AppPaletteContext on BuildContext {
  AppPalette get palette => Theme.of(this).extension<AppPalette>()!;
}

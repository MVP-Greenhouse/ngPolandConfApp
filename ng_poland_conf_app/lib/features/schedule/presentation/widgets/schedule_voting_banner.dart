import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/core/presentation/navigation/app_pages.dart';
import 'package:ng_poland_conf_app/core/presentation/theme/app_palette.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/pages/schedule_top5_page.dart';

class ScheduleVotingBanner extends StatelessWidget {
  const ScheduleVotingBanner({
    super.key,
    required this.track,
    required this.votingOpen,
    required this.top5Enabled,
  });

  final EventItemType track;
  final bool votingOpen;
  final bool top5Enabled;

  static const _outerPadding = EdgeInsets.fromLTRB(16, 12, 16, 4);
  static const _innerPadding = EdgeInsets.all(14);
  static const _iconSize = 32.0;
  static const _iconGap = 12.0;
  static const _arrowSize = 20.0;
  static const _titleGap = 4.0;
  static const _openTitle = 'LIVE VOTING IS OPEN!';
  static const _longestSubtitle =
      'Vote for your favorite talks • Top 5 ranking';

  /// Height of this banner, including its padding, for [AppBar.bottom].
  static double barExtent(BuildContext context) {
    final textDirection = Directionality.of(context);
    final textScaler = MediaQuery.textScalerOf(context);
    final titleStyle =
        Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: 0.2,
          fontSize: 13,
        ) ??
        const TextStyle(fontSize: 13, fontWeight: FontWeight.w800);
    final subtitleStyle =
        Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12) ??
        const TextStyle(fontSize: 12);
    final reservedWidth =
        _outerPadding.horizontal +
        _innerPadding.horizontal +
        _iconSize +
        _iconGap +
        _arrowSize;
    final textWidth = math.max(
      0.0,
      MediaQuery.sizeOf(context).width - reservedWidth,
    );
    final titleHeight = _textHeight(
      _openTitle,
      titleStyle,
      textDirection,
      textScaler,
      textWidth,
    );
    final subtitleHeight = _textHeight(
      _longestSubtitle,
      subtitleStyle,
      textDirection,
      textScaler,
      textWidth,
    );
    final contentHeight = math.max(
      _iconSize,
      titleHeight + _titleGap + subtitleHeight,
    );
    return (_outerPadding.vertical + _innerPadding.vertical + contentHeight)
        .ceilToDouble();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final highlight = votingOpen ? palette.accent : AppPalette.gold;

    final title = votingOpen ? _openTitle : 'VOTING CLOSED';
    final subtitle = switch ((votingOpen, top5Enabled)) {
      (false, _) => 'See the official Top 5 ranking',
      (true, true) => _longestSubtitle,
      (true, false) => 'Vote for your favorite talks',
    };

    return Padding(
      padding: _outerPadding,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: top5Enabled
              ? () {
                  context.pushNamed(
                    '${Pages.schedule.nameKey}-${ScheduleTop5Page.routeNameKey}',
                    pathParameters: {'eventItemType': track.name},
                  );
                }
              : null,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: palette.card,
              border: Border.all(
                color: highlight.withValues(alpha: votingOpen ? 0.55 : 0.45),
                width: 1.4,
              ),
              boxShadow: [
                BoxShadow(
                  color: highlight.withValues(alpha: 0.16),
                  blurRadius: 16,
                ),
              ],
            ),
            child: Padding(
              padding: _innerPadding,
              child: Row(
                children: [
                  Container(
                    width: _iconSize,
                    height: _iconSize,
                    alignment: .center,
                    decoration: BoxDecoration(
                      color: highlight.withValues(alpha: 0.16),
                      shape: .circle,
                    ),
                    child: Icon(
                      votingOpen
                          ? Icons.bolt_rounded
                          : Icons.emoji_events_rounded,
                      size: 18,
                      color: highlight,
                    ),
                  ),
                  const SizedBox(width: _iconGap),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.2,
                                color: highlight,
                                fontSize: 13,
                              ),
                        ),
                        const SizedBox(height: _titleGap),
                        Text(
                          subtitle,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(fontSize: 12, color: palette.muted),
                        ),
                      ],
                    ),
                  ),
                  if (top5Enabled)
                    Icon(
                      Icons.arrow_forward,
                      size: _arrowSize,
                      color: palette.muted,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

double _textHeight(
  String text,
  TextStyle style,
  TextDirection textDirection,
  TextScaler textScaler,
  double maxWidth,
) {
  final painter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: textDirection,
    textScaler: textScaler,
    maxLines: 2,
  )..layout(maxWidth: maxWidth);
  final height = painter.height;
  painter.dispose();
  return height;
}

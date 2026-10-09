import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/theme/app_palette.dart';

enum AppNoticeTone { success, warning, error }

class AppNotice {
  const AppNotice({
    required this.title,
    required this.body,
    required this.tone,
  });

  final String title;
  final String body;
  final AppNoticeTone tone;

  static const voteUnavailable = AppNotice(
    title: "This talk can't be voted on",
    body: 'It is not on the voting list, or the talk has not ended yet.',
    tone: AppNoticeTone.warning,
  );

  static AppNotice fromAdminMessage(String message) {
    if (message.startsWith('Synced ')) {
      return AppNotice(
        title: 'Voting list updated',
        body: message,
        tone: AppNoticeTone.success,
      );
    }
    if (message.startsWith('Could not sync')) {
      return const AppNotice(
        title: "Couldn't update the voting list",
        body:
            'The agenda request failed, so the current list was left unchanged.',
        tone: AppNoticeTone.error,
      );
    }
    return AppNotice(
      title: "Couldn't update the voting list",
      body: message,
      tone: AppNoticeTone.warning,
    );
  }
}

void showAppNotice(BuildContext context, AppNotice notice) {
  final messenger = ScaffoldMessenger.of(context);
  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(
    SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      padding: EdgeInsets.zero,
      duration: const Duration(seconds: 4),
      content: AppNoticeCard(notice: notice),
    ),
  );
}

class AppNoticeCard extends StatelessWidget {
  const AppNoticeCard({super.key, required this.notice});

  final AppNotice notice;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final highlight = switch (notice.tone) {
      AppNoticeTone.success => palette.accent,
      AppNoticeTone.warning => const Color(0xFFFFC107),
      AppNoticeTone.error => Theme.of(context).colorScheme.error,
    };
    final icon = switch (notice.tone) {
      AppNoticeTone.success => Icons.sync_rounded,
      AppNoticeTone.warning => Icons.how_to_vote_outlined,
      AppNoticeTone.error => Icons.error_outline_rounded,
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: highlight.withValues(alpha: 0.55)),
        boxShadow: [
          BoxShadow(color: highlight.withValues(alpha: 0.16), blurRadius: 16),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: highlight.withValues(alpha: 0.16),
                shape: BoxShape.circle,
              ),
              child: SizedBox(
                width: 32,
                height: 32,
                child: Icon(icon, size: 18, color: highlight),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notice.title,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.2,
                      color: highlight,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notice.body,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      height: 1.35,
                      color: palette.muted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

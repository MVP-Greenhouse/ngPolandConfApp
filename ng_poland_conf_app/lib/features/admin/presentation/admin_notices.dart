import 'package:ng_poland_conf_app/core/presentation/widgets/app_notice.dart';

/// Feedback shown after admin actions.
abstract final class AdminNotices {
  static AppNotice synced(String summary) =>
      AppNotice(title: 'Voting list updated', body: summary, tone: .success);

  static const syncFailed = AppNotice(
    title: "Couldn't update the voting list",
    body: 'The agenda request failed, so the current list was left unchanged.',
    tone: .error,
  );

  static AppNotice syncRejected(String reason) => AppNotice(
    title: "Couldn't update the voting list",
    body: reason,
    tone: .warning,
  );

  static AppNotice saveFailed(String reason) => AppNotice(
    title: "Couldn't save the settings",
    body: reason,
    tone: .error,
  );
}

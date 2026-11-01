import 'package:flutter_test/flutter_test.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/app_notice.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/admin_notices.dart';

void main() {
  test('sync summary becomes a success notice', () {
    final notice = AdminNotices.synced('Synced 12 votable events');

    expect(notice.title, 'Voting list updated');
    expect(notice.body, 'Synced 12 votable events');
    expect(notice.tone, AppNoticeTone.success);
  });

  test('failed agenda download is reported as an error', () {
    expect(AdminNotices.syncFailed.tone, AppNoticeTone.error);
    expect(AdminNotices.syncFailed.body, contains('left unchanged'));
  });

  test('rejected sync keeps the reason', () {
    final notice = AdminNotices.syncRejected('Agenda is for 2025');

    expect(notice.tone, AppNoticeTone.warning);
    expect(notice.body, 'Agenda is for 2025');
  });
}

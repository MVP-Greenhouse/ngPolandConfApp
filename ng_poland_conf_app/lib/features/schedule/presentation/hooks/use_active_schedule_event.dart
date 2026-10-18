import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ng_poland_conf_app/features/schedule/domain/services/schedule_timeline.dart';

/// Id of the slot happening now; updates when slots start or end and when
/// the app returns to the foreground.
String? useActiveScheduleEvent(List<ScheduleSlot> slots) {
  final active = useState<String?>(null);
  final resumes = useState(0);
  useOnAppLifecycleStateChange((_, state) {
    if (state == AppLifecycleState.resumed) resumes.value++;
  });

  useEffect(() {
    Timer? timer;
    void check() {
      final now = DateTime.now().toUtc();
      active.value = activeScheduleEventId(events: slots, now: now);
      final next = nextActiveScheduleCheckAt(events: slots, now: now);
      if (next == null) return;
      final delay = next.difference(now);
      // Clock / data edge: retry shortly instead of spinning.
      timer = Timer(
        delay > Duration.zero ? delay : const Duration(seconds: 1),
        check,
      );
    }

    check();
    return () => timer?.cancel();
  }, [slots, resumes.value]);

  return active.value;
}

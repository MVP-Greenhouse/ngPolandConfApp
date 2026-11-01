import 'dart:async';

import 'package:ng_poland_conf_app/features/engagement/domain/entities/engagement_config.dart';

/// Emits whether voting is open, again each time the window opens or closes.
Stream<bool> watchVotingOpen(
  TrackEngagementConfig config, {
  DateTime Function() now = DateTime.now,
}) {
  Timer? timer;
  late final StreamController<bool> controller;

  void tick() {
    final current = now();
    controller.add(config.isVotingOpen(current));
    if (config.nextWindowChangeAfter(current) case final next?) {
      timer = Timer(next.difference(current), tick);
    }
  }

  controller = StreamController<bool>(
    onListen: tick,
    onCancel: () {
      timer?.cancel();
      return controller.close();
    },
  );
  return controller.stream.distinct();
}

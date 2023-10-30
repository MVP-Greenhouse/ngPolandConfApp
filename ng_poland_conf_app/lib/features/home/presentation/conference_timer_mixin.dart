import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';

mixin ConferenceTimerMixin on Cubit<ConferencesState> {
  final ValueNotifier<int> timeToStartConferenceNotifier = ValueNotifier(0); // in seconds
  Timer? _timerToStartConference;

  void setTimer(String? conferencesStartDate) {
    _timerToStartConference?.cancel();

    if (conferencesStartDate == null) {
      timeToStartConferenceNotifier.value = 0;
      return;
    }

    timeToStartConferenceNotifier.value = Duration(
      milliseconds: DateTime.parse(conferencesStartDate).millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch,
    ).inSeconds;

    _timerToStartConference = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (timeToStartConferenceNotifier.value >= 0) {
          timeToStartConferenceNotifier.value -= 1;
        } else {
          timer.cancel();
        }
      },
    );
  }
}

import 'dart:async';

import 'package:flutter_hooks/flutter_hooks.dart';

/// Time left until [target], refreshed every second; zero once reached.
Duration useCountdown(DateTime? target) {
  Duration remaining() {
    if (target == null) return Duration.zero;
    final left = target.difference(DateTime.now());
    return left.isNegative ? Duration.zero : left;
  }

  final left = useState(remaining());
  useEffect(() {
    left.value = remaining();
    if (target == null) return null;
    final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      left.value = remaining();
      if (left.value == Duration.zero) timer.cancel();
    });
    return timer.cancel;
  }, [target]);
  return left.value;
}

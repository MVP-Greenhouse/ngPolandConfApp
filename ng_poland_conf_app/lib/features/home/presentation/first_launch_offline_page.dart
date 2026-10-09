import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ng_poland_conf_app/config/app_config.dart';
import 'package:ng_poland_conf_app/core/blocks/conferences/conferences_cubit.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/theme/app_palette.dart';
import 'package:url_launcher/url_launcher.dart';

const _tips = [
  (
    icon: Icons.signal_cellular_alt,
    title: 'Wi-Fi or mobile data',
    body:
        'Make sure the device has a stable connection to the Internet or the conference network.',
  ),
  (
    icon: Icons.airplanemode_active,
    title: 'Airplane mode',
    body: 'Check that wireless connectivity was not turned off by accident.',
  ),
];

class FirstLaunchOfflinePage extends StatefulWidget {
  const FirstLaunchOfflinePage({super.key});

  @override
  State<FirstLaunchOfflinePage> createState() => _FirstLaunchOfflinePageState();
}

class _FirstLaunchOfflinePageState extends State<FirstLaunchOfflinePage> {
  bool _retrying = false;

  Future<void> _retry() async {
    if (_retrying) return;
    setState(() => _retrying = true);
    try {
      await getIt.get<ConferencesCubit>().getConferences();
    } finally {
      if (mounted) setState(() => _retrying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Scaffold(
      backgroundColor: palette.screen,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
          children: [
            const _StatusPill(),
            const SizedBox(height: 28),
            const _OfflineMark(),
            const SizedBox(height: 28),
            Text(
              'NG POLAND 2026  •  Angular Conference',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: palette.accent,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Connection required',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: palette.onCard,
                fontSize: 28,
                fontWeight: FontWeight.w800,
                height: 1.15,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'A network connection is required the first time you open the NG Poland 2026 app, so it can download the current agenda, speaker list, and workshops. Later launches work offline as well.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: palette.muted,
                fontSize: 14,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 28),
            const _Tips(),
            const SizedBox(height: 28),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: palette.accent,
                foregroundColor: palette.onAccent,
                disabledBackgroundColor: palette.accent.withValues(alpha: 0.6),
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: _retrying ? null : _retry,
              child: _retrying
                  ? SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: palette.onAccent,
                      ),
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.refresh, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Try again',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 12),
            const _SettingsButton(),
            const SizedBox(height: 36),
            const _Footer(),
          ],
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill();

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: palette.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: palette.hairline),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: palette.accent,
                  shape: BoxShape.circle,
                ),
                child: const SizedBox(width: 8, height: 8),
              ),
              const SizedBox(width: 8),
              Text(
                'NO NETWORK CONNECTION',
                style: TextStyle(
                  color: palette.accent,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OfflineMark extends StatelessWidget {
  const _OfflineMark();

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Center(
      child: SizedBox(
        width: 148,
        height: 148,
        child: Stack(
          alignment: Alignment.center,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    palette.accent.withValues(alpha: 0.35),
                    palette.accent.withValues(alpha: 0),
                  ],
                ),
              ),
              child: const SizedBox.expand(),
            ),
            CustomPaint(
              size: const Size.square(112),
              painter: _DashedCirclePainter(
                color: palette.onCard.withValues(alpha: 0.35),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: palette.card,
                border: Border.all(color: palette.accent, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: palette.accent.withValues(alpha: 0.35),
                    blurRadius: 24,
                  ),
                ],
              ),
              child: SizedBox(
                width: 84,
                height: 84,
                child: Icon(Icons.wifi_off, color: palette.accent, size: 34),
              ),
            ),
            Positioned(
              right: 22,
              bottom: 22,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: palette.accent,
                  shape: BoxShape.circle,
                  border: Border.all(color: palette.screen, width: 3),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Icon(Icons.refresh, size: 14, color: palette.onAccent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashedCirclePainter extends CustomPainter {
  const _DashedCirclePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    final path = Path()..addOval(Offset.zero & size);
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(metric.extractPath(distance, distance + 5), paint);
        distance += 9;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedCirclePainter oldDelegate) =>
      oldDelegate.color != color;
}

class _Tips extends StatelessWidget {
  const _Tips();

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: palette.hairline),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.troubleshoot, size: 16, color: palette.muted),
                const SizedBox(width: 8),
                Text(
                  'Troubleshooting',
                  style: TextStyle(
                    color: palette.onCard,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            for (final tip in _tips) ...[
              _TipCard(icon: tip.icon, title: tip.title, body: tip.body),
              const SizedBox(height: 8),
            ],
          ],
        ),
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  const _TipCard({required this.icon, required this.title, required this.body});

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.panel,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: palette.chip,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                width: 36,
                height: 36,
                child: Icon(icon, size: 18, color: palette.onChip),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: palette.onCard,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    body,
                    style: TextStyle(
                      color: palette.muted,
                      fontSize: 12,
                      height: 1.35,
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

class _SettingsButton extends StatelessWidget {
  const _SettingsButton();

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: palette.onCard,
        backgroundColor: palette.card,
        minimumSize: const Size.fromHeight(52),
        side: BorderSide(color: palette.hairline),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onPressed: openNetworkSettings,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi, size: 18),
          SizedBox(width: 8),
          Text(
            'Check network settings',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on, size: 14, color: palette.accent),
            const SizedBox(width: 6),
            Text(
              'NG Poland 2026  •  Warsaw',
              style: TextStyle(
                color: palette.onCard,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'App build: v${AppConfig.version}',
          style: TextStyle(color: palette.muted, fontSize: 12),
        ),
      ],
    );
  }
}

const _networkSettingsChannel = MethodChannel('ngpoland/network_settings');

Future<void> openNetworkSettings() async {
  if (kIsWeb) return;
  if (defaultTargetPlatform == TargetPlatform.android) {
    try {
      await _networkSettingsChannel.invokeMethod<void>('open');
    } on MissingPluginException {
      return;
    } on PlatformException {
      return;
    }
    return;
  }
  final settings = Uri.parse('app-settings:');
  try {
    await launchUrl(settings, mode: LaunchMode.externalApplication);
  } catch (_) {}
}

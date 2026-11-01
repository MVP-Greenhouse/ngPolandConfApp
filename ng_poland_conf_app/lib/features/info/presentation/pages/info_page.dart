import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/core/presentation/theme/app_palette.dart';
import 'package:ng_poland_conf_app/core/presentation/theme/color_contrast.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/connection_status.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/custom_scaffold.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/empty_list_info.dart';
import 'package:ng_poland_conf_app/core/utils/hex_color.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/agenda.dart';
import 'package:ng_poland_conf_app/features/info/domain/entities/venue_info.dart';
import 'package:ng_poland_conf_app/features/info/presentation/cubit/info_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

/// Venue, dates and tickets. Expects an [InfoCubit] above it.
class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<InfoCubit>().state;
    final theme = Theme.of(context);
    return CustomScaffold(
      appBar: AppBar(
        title: Text(
          'Info',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.inversePrimary,
          ),
        ),
        actions: const [ConnectionStatus()],
      ),
      body: ColoredBox(
        color: context.palette.screen,
        child: switch (state) {
          InfoLoading() => const Center(child: CircularProgressIndicator()),
          InfoFailed() => const EmptyListInformation(),
          InfoLoaded(:final info) when info.isEmpty =>
            const EmptyListInformation(),
          InfoLoaded(:final info) => _InfoBody(info: info),
        },
      ),
    );
  }
}

class _InfoBody extends StatelessWidget {
  const _InfoBody({required this.info});

  final VenueInfo info;

  @override
  Widget build(BuildContext context) {
    final venue = info.venue;
    final muted = context.palette.muted;
    final headerStyle = TextStyle(
      color: muted,
      fontSize: 11,
      fontWeight: .w700,
      letterSpacing: 1.1,
    );

    return ListView(
      padding: .fromLTRB(16, 16, 16, 24 + MediaQuery.paddingOf(context).bottom),
      children: [
        if (venue != null) _VenueCard(venue: venue, city: info.city),
        if (info.ticketsUrl.isNotEmpty) ...[
          if (venue != null) const SizedBox(height: 16),
          _TicketsButton(url: info.ticketsUrl),
        ],
        if (info.days.isNotEmpty) ...[
          const SizedBox(height: 22),
          Row(
            children: [
              Text('WHEN', style: headerStyle),
              const Spacer(),
              Text(info.daysLabel, style: headerStyle),
            ],
          ),
          const SizedBox(height: 8),
          _DaysCard(days: info.days),
        ],
      ],
    );
  }
}

class _VenueCard extends StatelessWidget {
  const _VenueCard({required this.venue, required this.city});

  final Venue venue;
  final String? city;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final cityLabel = city;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [palette.panel, palette.card],
        ),
        border: Border.all(color: palette.hairline),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'VENUE',
                  style: TextStyle(
                    color: palette.muted,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                  ),
                ),
                const Spacer(),
                if (cityLabel != null)
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: palette.chip,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: palette.muted,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            cityLabel,
                            style: TextStyle(
                              color: palette.muted,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              venue.name,
              style: TextStyle(
                color: palette.onCard,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                height: 1.15,
              ),
            ),
            if (venue.address.isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: palette.accent,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      venue.address,
                      style: TextStyle(
                        color: palette.muted,
                        fontSize: 14,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            if (venue.mapsUrl.isNotEmpty) ...[
              const SizedBox(height: 14),
              Material(
                color: palette.panel,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: palette.hairline),
                ),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => _open(venue.mapsUrl),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.near_me_outlined,
                          size: 18,
                          color: palette.accent,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Open in Google Maps',
                            style: TextStyle(
                              color: palette.onCard,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Icon(Icons.open_in_new, size: 16, color: palette.muted),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TicketsButton extends StatelessWidget {
  const _TicketsButton({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: palette.accent,
        foregroundColor: palette.onAccent,
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onPressed: () => _open(url),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.confirmation_number_outlined, size: 18),
          SizedBox(width: 8),
          Text(
            'Tickets',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          SizedBox(width: 8),
          Icon(Icons.arrow_forward, size: 18),
        ],
      ),
    );
  }
}

class _DaysCard extends StatelessWidget {
  const _DaysCard({required this.days});

  final List<AgendaDay> days;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: palette.hairline),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        child: Column(
          children: [
            for (final (index, day) in days.indexed) ...[
              if (index > 0) Divider(height: 1, color: palette.hairline),
              _DayRow(day: day),
            ],
          ],
        ),
      ),
    );
  }
}

class _DayRow extends StatelessWidget {
  const _DayRow({required this.day});

  final AgendaDay day;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final accent = colorFromHex(day.color) ?? palette.accent;
    final workshop = day.kind == AgendaDayKind.workshops;
    final comingSoon = !workshop && !day.published;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (day.dateLabel.isNotEmpty)
                  Text(
                    day.dateLabel.toUpperCase(),
                    style: TextStyle(
                      color: palette.muted,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6,
                    ),
                  ),
                const SizedBox(height: 2),
                Text(
                  day.homeName,
                  style: TextStyle(
                    color: palette.onCard,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          if (workshop)
            _Badge(
              label: 'Workshop',
              background: accent,
              foreground: accent.readableForeground,
            )
          else if (comingSoon)
            _ComingSoon(color: accent),
        ],
      ),
    );
  }
}

class _ComingSoon extends StatelessWidget {
  const _ComingSoon({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: const SizedBox(width: 6, height: 6),
        ),
        const SizedBox(width: 6),
        Text(
          'Agenda coming soon',
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          label,
          style: TextStyle(
            color: foreground,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

void _open(String url) {
  if (Uri.tryParse(url) case final uri?) {
    launchUrl(uri, mode: .externalApplication);
  }
}

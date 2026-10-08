import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/features/edition/domains/entities/agenda.dart';
import 'package:ng_poland_conf_app/features/edition/domains/entities/edition.dart';
import 'package:ng_poland_conf_app/features/edition/presentation/edition_cubit.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/theme/app_palette.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';
import 'package:ng_poland_conf_app/widgets/empty_list_info.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../settings/presentation/connection_status.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late final EditionCubit _editionCubit;

  @override
  void initState() {
    super.initState();
    _editionCubit = getIt.get<EditionCubit>()..ensure();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text(
          'Info',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        actions: const [ConnectionStatus()],
      ),
      body: ColoredBox(
        color: context.palette.screen,
        child: StreamBuilder<EditionState>(
          stream: _editionCubit.stream,
          initialData: _editionCubit.state,
          builder: (context, _) {
            final edition = _editionCubit.current;
            if (edition == null) {
              return switch (_editionCubit.state) {
                EditionFailed() => const EmptyListInformation(),
                _ => const Center(child: CircularProgressIndicator()),
              };
            }
            if (edition.venue == null &&
                edition.ticketsUrl.isEmpty &&
                edition.days.isEmpty) {
              return const EmptyListInformation();
            }
            return _InfoBody(edition: edition);
          },
        ),
      ),
    );
  }
}

class _InfoBody extends StatelessWidget {
  const _InfoBody({required this.edition});

  final Edition edition;

  @override
  Widget build(BuildContext context) {
    final venue = edition.venue;
    final city = venue == null ? null : _cityLabel(venue.address);
    final muted = context.palette.muted;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        if (venue != null) _VenueCard(venue: venue, city: city),
        if (edition.ticketsUrl.isNotEmpty) ...[
          if (venue != null) const SizedBox(height: 16),
          _TicketsButton(url: edition.ticketsUrl),
        ],
        if (edition.days.isNotEmpty) ...[
          const SizedBox(height: 22),
          Row(
            children: [
              Text(
                'WHEN',
                style: TextStyle(
                  color: muted,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.1,
                ),
              ),
              const Spacer(),
              Text(
                _daysLabel(edition.days),
                style: TextStyle(
                  color: muted,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _DaysCard(days: edition.days),
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
    final accent = _color(day.color) ?? palette.accent;
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
              foreground: accent.computeLuminance() > 0.55
                  ? Colors.black
                  : Colors.white,
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

String? _cityLabel(String address) {
  final parts = [
    for (final part in address.split(','))
      if (part.trim().isNotEmpty) part.trim(),
  ];
  if (parts.length < 2) return null;
  final country = parts.last;
  final city = parts[parts.length - 2].replaceFirst(
    RegExp(r'^\d{2}-\d{3}\s+'),
    '',
  );
  if (city.isEmpty) return null;
  final countryLabel = country.toLowerCase() == 'poland' ? 'PL' : country;
  return '$city, $countryLabel';
}

String _daysLabel(List<AgendaDay> days) {
  final count = days.length;
  final unit = count == 1 ? 'DAY' : 'DAYS';
  if (count > 1 && _consecutive(days)) return '$count CONSECUTIVE $unit';
  return '$count $unit';
}

bool _consecutive(List<AgendaDay> days) {
  final dates = [for (final day in days) DateTime.tryParse(day.date)];
  if (dates.any((date) => date == null)) return false;
  for (var i = 1; i < dates.length; i++) {
    final previous = dates[i - 1];
    final current = dates[i];
    if (previous == null || current == null) return false;
    if (current.difference(previous).inDays != 1) return false;
  }
  return true;
}

void _open(String url) {
  final uri = Uri.tryParse(url);
  if (uri == null) return;
  launchUrl(uri, mode: LaunchMode.externalApplication);
}

Color? _color(String hex) {
  final value = hex.replaceFirst('#', '');
  if (value.length != 6) return null;
  final parsed = int.tryParse(value, radix: 16);
  if (parsed == null) return null;
  return Color(0xFF000000 | parsed);
}

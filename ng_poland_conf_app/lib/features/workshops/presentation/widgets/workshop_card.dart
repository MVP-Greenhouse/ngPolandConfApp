import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/core/utils/network_photo_url.dart';
import 'package:ng_poland_conf_app/features/edition/domains/entities/agenda.dart';
import 'package:ng_poland_conf_app/features/edition/domains/entities/edition.dart';
import 'package:ng_poland_conf_app/features/edition/presentation/edition_cubit.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/widgets/speaker_details.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/routing/routing.dart';
import 'package:ng_poland_conf_app/theme/app_palette.dart';
import 'package:ng_poland_conf_app/widgets/fixed_size_cross_origin_image.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkshopCard extends StatelessWidget {
  const WorkshopCard({super.key, required this.workshop});

  final WorkshopAgendaItem workshop;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final accent = _color(workshop.color) ?? palette.accent;
    final edition = getIt.get<EditionCubit>().current;
    final year = edition?.year ?? 0;
    final price = [
      if (workshop.pricePln != null) '${workshop.pricePln} PLN',
      if (workshop.priceEur != null) '${workshop.priceEur} EUR',
    ].join(' / ');
    final conference = [
      workshop.conferenceLabel.toUpperCase(),
      if (year > 0) '$year',
    ].join(' ');
    final showHeader =
        workshop.conferenceLabel.isNotEmpty ||
        workshop.level.isNotEmpty ||
        workshop.timeLabel.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: palette.card,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: palette.hairline),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showHeader) ...[
                _Header(
                  workshop: workshop,
                  conference: conference,
                  accent: accent,
                ),
                const SizedBox(height: 12),
              ],
              Text(
                workshop.displayTitle,
                style: TextStyle(
                  color: palette.onCard,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
              if (workshop.speakers.isNotEmpty) ...[
                const SizedBox(height: 14),
                _SpeakerPanel(
                  conference: workshop.conference,
                  speakers: [
                    for (final speaker in workshop.speakers)
                      (speaker: speaker, role: _role(speaker, edition)),
                  ],
                ),
              ],
              if (workshop.lunchProvided || price.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if (workshop.lunchProvided)
                      _InfoChip(
                        icon: Icons.restaurant_outlined,
                        iconColor: palette.muted,
                        label: 'Hot Lunch Included',
                      ),
                    if (price.isNotEmpty)
                      _InfoChip(
                        icon: Icons.credit_card_outlined,
                        iconColor: palette.accent,
                        label: price,
                      ),
                  ],
                ),
              ],
              if (workshop.benefits.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  'KEY TAKEAWAYS',
                  style: TextStyle(
                    color: palette.muted,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 8),
                _Takeaways(benefits: workshop.benefits),
              ],
              if (workshop.description.isNotEmpty ||
                  workshop.descriptionHtml.isNotEmpty) ...[
                const SizedBox(height: 10),
                _About(
                  description: workshop.description,
                  descriptionHtml: workshop.descriptionHtml,
                ),
              ],
              if (workshop.buyUrl.isNotEmpty) ...[
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: palette.accent,
                      foregroundColor: palette.onAccent,
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      final uri = Uri.tryParse(workshop.buyUrl);
                      if (uri == null) return;
                      launchUrl(uri, mode: LaunchMode.externalApplication);
                    },
                    icon: const Icon(Icons.shopping_cart_outlined, size: 18),
                    label: const Text('Buy Ticket'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _role(SpeakerSummary speaker, Edition? edition) {
    if (speaker.roleLabel.isNotEmpty) return speaker.roleLabel;
    if (speaker.slug.isEmpty) return '';
    return edition
            ?.speakerBySlug(speaker.slug, conference: workshop.conference)
            ?.roleLabel ??
        '';
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.workshop,
    required this.conference,
    required this.accent,
  });

  final WorkshopAgendaItem workshop;
  final String conference;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (workshop.conferenceLabel.isNotEmpty)
                _Pill(
                  label: conference,
                  background: accent,
                  foreground: accent.computeLuminance() > 0.55
                      ? Colors.black
                      : Colors.white,
                ),
              if (workshop.level.isNotEmpty)
                _Pill(
                  label: workshop.level,
                  background: palette.chip,
                  foreground: palette.onChip,
                ),
            ],
          ),
        ),
        if (workshop.timeLabel.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.schedule, size: 14, color: palette.muted),
                const SizedBox(width: 4),
                Text(
                  workshop.timeLabel,
                  style: TextStyle(
                    color: palette.muted,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _SpeakerPanel extends StatelessWidget {
  const _SpeakerPanel({required this.speakers, required this.conference});

  final List<({SpeakerSummary speaker, String role})> speakers;
  final String conference;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.panel,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: palette.hairline),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          children: [
            for (final (index, entry) in speakers.indexed)
              InkWell(
                onTap: entry.speaker.slug.isEmpty
                    ? null
                    : () {
                        final slugs = [
                          for (final item in speakers)
                            if (item.speaker.slug.isNotEmpty) item.speaker.slug,
                        ];
                        context.pushNamed(
                          '${Pages.workshops.nameKey}-${SpeakerDetails.routeNameKey}',
                          pathParameters: {'id': entry.speaker.slug},
                          queryParameters: {
                            if (slugs.length > 1) 'speakers': slugs.join(','),
                            if (conference.isNotEmpty) 'conference': conference,
                          },
                        );
                      },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    12,
                    index == 0 ? 12 : 6,
                    12,
                    index == speakers.length - 1 ? 12 : 6,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 48,
                        height: 48,
                        child: FixedSizeCrossOriginImage(
                          imageUrl: networkPhotoUrl(entry.speaker.photo),
                          size: 48,
                          placeholderAsset: 'assets/images/person.png',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.speaker.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: palette.onCard,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            if (entry.role.isNotEmpty)
                              Text(
                                entry.role,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: palette.muted,
                                  fontSize: 13,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Takeaways extends StatelessWidget {
  const _Takeaways({required this.benefits});

  final List<String> benefits;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.panel,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: palette.hairline),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          children: [
            for (final (index, benefit) in benefits.indexed)
              Padding(
                padding: EdgeInsets.only(top: index == 0 ? 0 : 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: Icon(
                        Icons.check_circle,
                        size: 18,
                        color: palette.accent,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        benefit,
                        style: TextStyle(
                          color: palette.onCard,
                          height: 1.35,
                          fontSize: 14,
                        ),
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

class _About extends StatelessWidget {
  const _About({required this.description, required this.descriptionHtml});

  final String description;
  final String descriptionHtml;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final copy = TextStyle(color: palette.muted, height: 1.4, fontSize: 14);
    return Material(
      color: palette.panel,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: palette.hairline),
      ),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 12),
          childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          iconColor: palette.muted,
          collapsedIconColor: palette.muted,
          leading: Icon(Icons.info_outline, color: palette.muted, size: 20),
          title: Text(
            'About this workshop',
            style: TextStyle(
              color: palette.onCard,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          children: [
            if (description.isNotEmpty)
              Text(description, style: copy)
            else
              HtmlWidget(descriptionHtml, textStyle: copy),
          ],
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
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

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.iconColor,
    required this.label,
  });

  final IconData icon;
  final Color iconColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: palette.hairline),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: iconColor),
            const SizedBox(width: 6),
            Text(label, style: TextStyle(color: palette.onCard, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

Color? _color(String hex) {
  final value = hex.replaceFirst('#', '');
  if (value.length != 6) return null;
  final parsed = int.tryParse(value, radix: 16);
  if (parsed == null) return null;
  return Color(0xFF000000 | parsed);
}

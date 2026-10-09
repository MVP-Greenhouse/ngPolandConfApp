import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/core/utils/hex_color.dart';
import 'package:ng_poland_conf_app/core/utils/network_photo_url.dart';
import 'package:ng_poland_conf_app/features/edition/domains/entities/edition.dart';
import 'package:ng_poland_conf_app/features/edition/domains/entities/speaker_profile.dart';
import 'package:ng_poland_conf_app/features/edition/domains/logic/edition_projections.dart';
import 'package:ng_poland_conf_app/features/edition/presentation/edition_cubit.dart';
import 'package:ng_poland_conf_app/features/event/presentation/event_page.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/routing/routing.dart';
import 'package:ng_poland_conf_app/theme/app_palette.dart';
import 'package:ng_poland_conf_app/widgets/app_image_cache.dart';
import 'package:ng_poland_conf_app/widgets/caching_html_widget_factory.dart';
import 'package:ng_poland_conf_app/widgets/custom_back_button.dart';
import 'package:ng_poland_conf_app/widgets/empty_list_info.dart';
import 'package:ng_poland_conf_app/widgets/fixed_size_cross_origin_image.dart';
import 'package:url_launcher/url_launcher.dart';

class SpeakerDetails extends StatefulWidget {
  const SpeakerDetails({
    super.key,
    required this.id,
    this.workshopSpeakerIds = const [],
    this.conference = '',
  });

  final String id;
  final List<String> workshopSpeakerIds;
  final String conference;

  static const routeName = 'deatils';
  static const routeNameKey = 'SpeakerDetails';

  @override
  State<SpeakerDetails> createState() => _SpeakerDetailsState();
}

class _SpeakerDetailsState extends State<SpeakerDetails> {
  late final EditionCubit _editionCubit;
  late String _selectedId;

  @override
  void initState() {
    super.initState();
    _editionCubit = getIt.get<EditionCubit>()..ensure();
    _selectedId = widget.id;
  }

  @override
  void didUpdateWidget(SpeakerDetails oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.id != widget.id) _selectedId = widget.id;
  }

  List<String> get _switchIds {
    final ids = [
      for (final id in widget.workshopSpeakerIds)
        if (id.isNotEmpty) id,
    ];
    if (ids.length < 2) return const [];
    if (!ids.contains(widget.id)) return [widget.id, ...ids];
    return ids;
  }

  @override
  Widget build(BuildContext context) {
    final switchIds = _switchIds;
    return Scaffold(
      backgroundColor: context.palette.screen,
      appBar: AppBar(
        title: Text(
          'Speaker',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        leading: const CustomBackButton(),
      ),
      body: StreamBuilder<EditionState>(
        stream: _editionCubit.stream,
        initialData: _editionCubit.state,
        builder: (context, _) {
          final profile = _editionCubit.current?.speakerBySlug(
            _selectedId,
            conference: widget.conference,
          );
          if (profile == null) {
            return switch (_editionCubit.state) {
              EditionFailed() => const EmptyListInformation(),
              EditionReady() => const EmptyListInformation(),
              _ => const Center(child: CircularProgressIndicator()),
            };
          }
          return _SpeakerBody(
            profile: profile,
            conference: widget.conference,
            speakerIds: switchIds,
            selectedId: _selectedId,
            onSpeakerSelected: switchIds.length > 1
                ? (id) => setState(() => _selectedId = id)
                : null,
          );
        },
      ),
    );
  }
}

class _SpeakerBody extends StatelessWidget {
  const _SpeakerBody({
    required this.profile,
    required this.conference,
    required this.speakerIds,
    required this.selectedId,
    required this.onSpeakerSelected,
  });

  final SpeakerProfile profile;
  final String conference;
  final List<String> speakerIds;
  final String selectedId;
  final ValueChanged<String>? onSpeakerSelected;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final accent = colorFromHex(profile.color) ?? palette.accent;
    final workshops = uniqueSpeakerWorkshops(
      profile.workshops,
      conference: conference.isNotEmpty ? conference : profile.conference,
    );
    final bio = profile.bio;
    final bioHtml = profile.bioHtml;
    final talk = profile.talk;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        if (onSpeakerSelected case final onSelected?) ...[
          _SpeakerSwitch(
            speakerIds: speakerIds,
            selectedId: selectedId,
            conference: conference,
            onSelected: onSelected,
          ),
          const SizedBox(height: 16),
        ],
        Center(
          child: SizedBox(
            width: 112,
            height: 112,
            child: FixedSizeCrossOriginImage(
              imageUrl: networkPhotoUrl(profile.photo),
              size: 112,
              placeholderAsset: 'assets/images/person.png',
            ),
          ),
        ),
        if (profile.conferenceLabel.isNotEmpty) ...[
          const SizedBox(height: 16),
          Center(
            child: _Pill(
              label: profile.conferenceLabel.toUpperCase(),
              background: accent,
              foreground: accent.computeLuminance() > 0.55
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ],
        const SizedBox(height: 12),
        Text(
          profile.name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: palette.onCard,
            fontSize: 28,
            fontWeight: FontWeight.w800,
            height: 1.15,
          ),
        ),
        if (profile.roleLabel.isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(
            profile.roleLabel,
            textAlign: TextAlign.center,
            style: TextStyle(color: palette.muted, fontSize: 14),
          ),
        ],
        if (profile.country.isNotEmpty) ...[
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on_outlined, size: 14, color: palette.muted),
              const SizedBox(width: 4),
              Text(
                profile.country,
                style: TextStyle(color: palette.muted, fontSize: 13),
              ),
            ],
          ),
        ],
        if (profile.socials.isNotEmpty) ...[
          const SizedBox(height: 14),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: [
              for (final social in profile.socials)
                _SocialButton(network: social.network, url: social.url),
            ],
          ),
        ],
        if (bio.isNotEmpty || bioHtml.isNotEmpty) ...[
          const SizedBox(height: 16),
          _RichCopy(plain: bio, html: bioHtml, textAlign: TextAlign.center),
        ],
        if (talk != null &&
            (talk.title.isNotEmpty ||
                talk.description.isNotEmpty ||
                talk.descriptionHtml.isNotEmpty)) ...[
          const SizedBox(height: 20),
          _Section(
            icon: Icons.circle,
            title: 'TALK',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (talk.title.isNotEmpty)
                  Text(
                    talk.title,
                    style: TextStyle(
                      color: palette.onCard,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                    ),
                  ),
                if (talk.description.isNotEmpty ||
                    talk.descriptionHtml.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  _RichCopy(
                    plain: talk.description,
                    html: talk.descriptionHtml,
                  ),
                ],
              ],
            ),
          ),
        ],
        if (workshops.isNotEmpty) ...[
          const SizedBox(height: 12),
          _Section(
            icon: Icons.grid_view_rounded,
            title: 'WORKSHOPS',
            trailing: workshops.length == 1
                ? '1 Session'
                : '${workshops.length} Sessions',
            child: Column(
              children: [
                for (final (index, workshop) in workshops.indexed) ...[
                  if (index > 0) const SizedBox(height: 8),
                  _WorkshopTile(workshop: workshop),
                ],
              ],
            ),
          ),
        ],
        if (profile.videos.isNotEmpty) ...[
          const SizedBox(height: 12),
          _Section(
            icon: Icons.circle,
            title: 'VIDEOS',
            child: Column(
              children: [
                for (final (index, video) in profile.videos.indexed) ...[
                  if (index > 0) const SizedBox(height: 10),
                  _VideoTile(video: video),
                ],
              ],
            ),
          ),
        ],
        if (profile.books.isNotEmpty) ...[
          const SizedBox(height: 12),
          _Section(
            icon: Icons.menu_book_outlined,
            title: 'BOOKS',
            child: Column(
              children: [
                for (final (index, book) in profile.books.indexed) ...[
                  if (index > 0) const SizedBox(height: 10),
                  _BookTile(book: book),
                ],
              ],
            ),
          ),
        ],
        if (profile.agendaItems.isNotEmpty) ...[
          const SizedBox(height: 12),
          _Section(
            icon: Icons.event_outlined,
            title: 'AGENDA',
            child: Column(
              children: [
                for (final (index, item) in profile.agendaItems.indexed) ...[
                  if (index > 0) const SizedBox(height: 8),
                  _AgendaTile(item: item),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _SpeakerSwitch extends StatelessWidget {
  const _SpeakerSwitch({
    required this.speakerIds,
    required this.selectedId,
    required this.conference,
    required this.onSelected,
  });

  final List<String> speakerIds;
  final String selectedId;
  final String conference;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final edition = context.read<EditionCubit>().current;
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final (index, id) in speakerIds.indexed) ...[
                  if (index > 0) const SizedBox(width: 8),
                  _SpeakerChip(
                    label:
                        edition
                            ?.speakerBySlug(id, conference: conference)
                            ?.name ??
                        id,
                    selected: id == selectedId,
                    onTap: () => onSelected(id),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SpeakerChip extends StatelessWidget {
  const _SpeakerChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Material(
      color: selected ? palette.accent : palette.panel,
      shape: StadiumBorder(
        side: BorderSide(color: selected ? palette.accent : palette.hairline),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? palette.onAccent : palette.onCard,
              fontSize: 13,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _RichCopy extends StatelessWidget {
  const _RichCopy({
    required this.plain,
    required this.html,
    this.textAlign = TextAlign.start,
  });

  final String plain;
  final String html;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: context.palette.muted,
      fontSize: 12,
      height: 1.45,
    );
    if (plain.isNotEmpty) {
      return Text(plain, textAlign: textAlign, style: style);
    }
    return HtmlWidget(
      html,
      factoryBuilder: CachingHtmlWidgetFactory.new,
      textStyle: style,
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.icon,
    required this.title,
    required this.child,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final String? trailing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.panel,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: palette.hairline),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: icon == Icons.circle ? 8 : 16,
                  color: palette.accent,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: palette.muted,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                  ),
                ),
                const Spacer(),
                if (trailing case final label?)
                  Text(
                    label,
                    style: TextStyle(color: palette.muted, fontSize: 12),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _WorkshopTile extends StatelessWidget {
  const _WorkshopTile({required this.workshop});

  final SpeakerWorkshopRef workshop;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final edition = context.read<EditionCubit>().current;
    final date = _workshopDateLabel(workshop, edition);
    return Material(
      color: palette.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: palette.hairline),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _openWorkshop(context, workshop, edition),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (workshop.level.isNotEmpty)
                    _Pill(
                      label: workshop.level,
                      background: palette.chip,
                      foreground: palette.onChip,
                    ),
                  if (workshop.level.isNotEmpty && date != null)
                    const SizedBox(width: 8),
                  if (date != null) ...[
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 12,
                      color: palette.muted,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      date,
                      style: TextStyle(color: palette.muted, fontSize: 12),
                    ),
                  ],
                  const Spacer(),
                  if (workshop.url.isNotEmpty || workshop.id != 0)
                    Icon(Icons.chevron_right, size: 18, color: palette.muted),
                ],
              ),
              if (workshop.level.isNotEmpty || date != null)
                const SizedBox(height: 8),
              Text(
                workshop.title,
                style: TextStyle(
                  color: palette.onCard,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VideoTile extends StatelessWidget {
  const _VideoTile({required this.video});

  final SpeakerVideo video;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final ratio = MediaQuery.devicePixelRatioOf(context);
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: 120,
            height: 72,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: video.thumbnail,
                  fit: BoxFit.cover,
                  cacheManager: kIsWeb ? null : AppImageCache.instance,
                  memCacheWidth: (120 * ratio).ceil(),
                  memCacheHeight: (72 * ratio).ceil(),
                  fadeInDuration: Duration.zero,
                  fadeOutDuration: Duration.zero,
                  errorWidget: (_, _, _) => ColoredBox(
                    color: palette.card,
                    child: Icon(Icons.play_circle, color: palette.muted),
                  ),
                ),
                const Center(
                  child: Icon(
                    Icons.play_circle_fill,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: palette.accent,
            foregroundColor: palette.onAccent,
            visualDensity: VisualDensity.compact,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () => _open(video.url),
          child: const Text('Watch'),
        ),
      ],
    );
  }
}

class _BookTile extends StatelessWidget {
  const _BookTile({required this.book});

  final SpeakerBook book;

  @override
  Widget build(BuildContext context) {
    final ratio = MediaQuery.devicePixelRatioOf(context);
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: book.cover,
            width: 48,
            height: 72,
            fit: BoxFit.cover,
            cacheManager: kIsWeb ? null : AppImageCache.instance,
            memCacheWidth: (48 * ratio).ceil(),
            memCacheHeight: (72 * ratio).ceil(),
            fadeInDuration: Duration.zero,
            fadeOutDuration: Duration.zero,
            errorWidget: (_, _, _) =>
                Icon(Icons.menu_book, color: context.palette.muted),
          ),
        ),
        const Spacer(),
        if (book.url case final url?)
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: context.palette.accent,
              foregroundColor: context.palette.onAccent,
              visualDensity: VisualDensity.compact,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () => _open(url),
            child: const Text('Open'),
          ),
      ],
    );
  }
}

class _AgendaTile extends StatelessWidget {
  const _AgendaTile({required this.item});

  final SpeakerAgendaRef item;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Material(
      color: palette.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: palette.hairline),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          final track = trackForConferenceKey(item.conference);
          if (track == null) return;
          context.pushNamed(
            '${Pages.schedule.nameKey}-${EventPage.routeNameKey}',
            pathParameters: {
              'eventId': item.eventId,
              'eventItemType': track.name,
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            item.title,
            style: TextStyle(
              color: palette.onCard,
              fontSize: 13,
              height: 1.3,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.network, required this.url});

  final String network;
  final String url;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Material(
      color: Colors.transparent,
      shape: CircleBorder(side: BorderSide(color: palette.hairline)),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () => _open(url),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Center(
            child: FaIcon(_socialIcon(network), size: 16, color: palette.muted),
          ),
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

String? _workshopDayKey(SpeakerWorkshopRef workshop, Edition? edition) {
  if (edition == null) return null;
  for (final day in edition.days) {
    for (final item in day.workshopItems) {
      if (item.id == workshop.id) return day.key;
    }
  }
  return null;
}

void _openWorkshop(
  BuildContext context,
  SpeakerWorkshopRef workshop,
  Edition? edition,
) {
  final dayKey = _workshopDayKey(workshop, edition);
  context.go(
    Uri(
      path: Pages.workshops.path,
      queryParameters: {
        if (dayKey != null && dayKey.isNotEmpty) 'day': dayKey,
        if (workshop.id != 0) 'workshop': '${workshop.id}',
      },
    ).toString(),
  );
}

String? _workshopDateLabel(SpeakerWorkshopRef workshop, Edition? edition) {
  final own = _dateLabel(workshop.date);
  if (own != null) return own;
  if (edition == null) return null;
  for (final day in edition.days) {
    if (day.dateLabel.isEmpty) continue;
    for (final item in day.workshopItems) {
      if (item.id == workshop.id) return day.dateLabel;
    }
  }
  return null;
}

String? _dateLabel(String date) {
  final parts = date.split('-');
  if (parts.length != 3) return null;
  final month = int.tryParse(parts[1]);
  final day = int.tryParse(parts[2]);
  if (month == null || day == null || month < 1 || month > 12) return null;
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${months[month - 1]} $day, ${parts[0]}';
}

void _open(String url) {
  final uri = Uri.tryParse(url);
  if (uri == null) return;
  launchUrl(uri, mode: LaunchMode.externalApplication);
}

FaIconData _socialIcon(String network) => switch (network) {
  'linkedin' => FontAwesomeIcons.linkedin,
  'x' => FontAwesomeIcons.xTwitter,
  'github' => FontAwesomeIcons.github,
  'youtube' => FontAwesomeIcons.youtube,
  'instagram' => FontAwesomeIcons.instagram,
  'facebook' => FontAwesomeIcons.facebook,
  'medium' => FontAwesomeIcons.medium,
  _ => FontAwesomeIcons.globe,
};

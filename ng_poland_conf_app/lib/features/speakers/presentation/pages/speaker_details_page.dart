import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/core/presentation/navigation/app_pages.dart';
import 'package:ng_poland_conf_app/core/presentation/theme/app_palette.dart';
import 'package:ng_poland_conf_app/core/presentation/theme/color_contrast.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/app_image_cache.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/caching_html_widget_factory.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/custom_back_button.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/empty_list_info.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/fixed_size_cross_origin_image.dart';
import 'package:ng_poland_conf_app/core/utils/hex_color.dart';
import 'package:ng_poland_conf_app/core/utils/network_photo_url.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/speaker_profile.dart';
import 'package:ng_poland_conf_app/features/event/presentation/pages/event_page.dart';
import 'package:ng_poland_conf_app/features/speakers/domain/entities/speaker_details.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/cubit/speaker_details_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

/// Speaker profile. Expects a [SpeakerDetailsCubit] above it.
class SpeakerDetailsPage extends StatelessWidget {
  const SpeakerDetailsPage({super.key});

  static const routeName = 'deatils';
  static const routeNameKey = 'SpeakerDetails';

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SpeakerDetailsCubit>().state;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: context.palette.screen,
      appBar: AppBar(
        title: Text(
          'Speaker',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.inversePrimary,
          ),
        ),
        leading: const CustomBackButton(),
      ),
      body: switch (state) {
        SpeakerDetailsLoading() => const Center(
          child: CircularProgressIndicator(),
        ),
        SpeakerDetailsFailed() => const EmptyListInformation(),
        SpeakerDetailsLoaded(:final details, :final conference) => _SpeakerBody(
          details: details,
          conference: conference,
        ),
      },
    );
  }
}

class _SpeakerBody extends StatelessWidget {
  const _SpeakerBody({required this.details, required this.conference});

  final SpeakerDetails details;
  final String conference;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final profile = details.profile;
    final accent = colorFromHex(profile.color) ?? palette.accent;
    final workshops = details.workshops;
    final bio = profile.bio;
    final bioHtml = profile.bioHtml;
    final talk = profile.talk;

    return ListView(
      padding: EdgeInsets.fromLTRB(
        16,
        8,
        16,
        24 + MediaQuery.paddingOf(context).bottom,
      ),
      children: [
        if (details.coSpeakers.length > 1) ...[
          _SpeakerSwitch(
            coSpeakers: details.coSpeakers,
            selectedSlug: profile.slug,
            onSelected: context.read<SpeakerDetailsCubit>().selectSpeaker,
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
              foreground: accent.readableForeground,
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
                  _WorkshopTile(item: workshop),
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
    required this.coSpeakers,
    required this.selectedSlug,
    required this.onSelected,
  });

  final List<CoSpeaker> coSpeakers;
  final String selectedSlug;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final (index, coSpeaker) in coSpeakers.indexed) ...[
                  if (index > 0) const SizedBox(width: 8),
                  _SpeakerChip(
                    label: coSpeaker.name,
                    selected: coSpeaker.slug == selectedSlug,
                    onTap: () => onSelected(coSpeaker.slug),
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
  const _WorkshopTile({required this.item});

  final SpeakerWorkshop item;

  SpeakerWorkshopRef get workshop => item.workshop;

  void _open(BuildContext context) {
    context.go(
      Uri(
        path: Pages.workshops.path,
        queryParameters: {
          if (item.dayKey case final dayKey? when dayKey.isNotEmpty)
            'day': dayKey,
          if (workshop.id != 0) 'workshop': '${workshop.id}',
        },
      ).toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final date = item.dateLabel;
    return Material(
      color: palette.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: palette.hairline),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _open(context),
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
          final track = EventItemType.fromConferenceKey(item.conference);
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

void _open(String url) {
  if (Uri.tryParse(url) case final uri?) {
    launchUrl(uri, mode: .externalApplication);
  }
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

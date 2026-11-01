import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/core/presentation/navigation/app_pages.dart';
import 'package:ng_poland_conf_app/core/presentation/theme/app_palette.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/caching_html_widget_factory.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/connection_status.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/custom_back_button.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/custom_scaffold.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/simple_cross_origin_image.dart';
import 'package:ng_poland_conf_app/core/utils/network_photo_url.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/event_item_type.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/speaker.dart';
import 'package:ng_poland_conf_app/features/event/presentation/cubit/event_cubit.dart';
import 'package:ng_poland_conf_app/features/event/presentation/widgets/event_vote_button.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/pages/speaker_details_page.dart';
import 'package:url_launcher/url_launcher.dart';

/// Session details. Expects an [EventCubit] and an [EventVoteCubit] above it.
class EventPage extends StatelessWidget {
  static const routeName = 'event';
  static const routeNameKey = 'EventPage';

  const EventPage({super.key, required this.track});

  final EventItemType track;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final theme = Theme.of(context);
    return CustomScaffold(
      showDrawer: false,
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text(
          'Event',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.inversePrimary,
          ),
        ),
        actions: const [ConnectionStatus()],
      ),
      body: ColoredBox(
        color: palette.screen,
        child: BlocBuilder<EventCubit, EventState>(
          builder: (context, state) => switch (state) {
            EventLoading() => const Center(child: CircularProgressIndicator()),
            EventLoaded(:final event, :final hasDescription) => _EventBody(
              eventItem: event,
              track: track,
              hasDescription: hasDescription,
            ),
            EventFailed() => const SizedBox.shrink(),
          },
        ),
      ),
    );
  }
}

class _EventBody extends StatelessWidget {
  const _EventBody({
    required this.eventItem,
    required this.track,
    required this.hasDescription,
  });

  final EventItem eventItem;
  final EventItemType track;
  final bool hasDescription;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final session = eventItem.sessionLabel.trim();
    final time = eventItem.timeRangeLabel;

    return ListView(
      padding: .fromLTRB(16, 12, 16, 28 + MediaQuery.paddingOf(context).bottom),
      children: [
        if (time.isNotEmpty)
          Text(
            time,
            style: TextStyle(
              color: palette.muted,
              fontSize: 13,
              fontWeight: .w500,
            ),
          ),
        const SizedBox(height: 6),
        Text(
          eventItem.title,
          style: TextStyle(
            color: palette.onCard,
            fontSize: 26,
            height: 1.2,
            fontWeight: .w700,
          ),
        ),
        if (session.isNotEmpty) ...[
          const SizedBox(height: 12),
          Align(
            alignment: .centerLeft,
            child: _SessionChip(label: session),
          ),
        ],
        if (eventItem.allSpeakers case final speakers
            when speakers.isNotEmpty) ...[
          const SizedBox(height: 18),
          for (final speaker in speakers) ...[
            _SpeakerCard(speaker: speaker, track: track),
            const SizedBox(height: 12),
          ],
        ],
        if (eventItem.hasSpeaker && !eventItem.isBreak) ...[
          const EventVoteSection(),
          const SizedBox(height: 12),
        ],
        if (hasDescription)
          _DescriptionCard(
            html: eventItem.descriptionHtml.trim(),
            plain: eventItem.description?.trim() ?? '',
          ),
      ],
    );
  }
}

class _SessionChip extends StatelessWidget {
  const _SessionChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.chip,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          label,
          style: TextStyle(
            color: palette.onChip,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _SpeakerCard extends StatelessWidget {
  const _SpeakerCard({required this.speaker, required this.track});

  final Speaker speaker;
  final EventItemType track;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final photo = networkPhotoUrl(speaker.photoFileUrl);
    final website = speaker.urlWww?.trim() ?? '';
    final name = speaker.name;
    final role = speaker.role;
    final speakerId = speaker.id;

    return Material(
      color: palette.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: BorderSide(color: palette.hairline),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: speakerId == null || speakerId.isEmpty
            ? null
            : () => _openSpeaker(context, speakerId),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              ClipOval(
                child: photo.isEmpty
                    ? Image.asset(
                        'assets/images/person.png',
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                      )
                    : SimpleCrossOriginImage(
                        imageUrl: photo,
                        width: 56,
                        height: 56,
                        placeholderAsset: 'assets/images/person.png',
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (name case final speakerName?
                        when speakerName.isNotEmpty)
                      Text(
                        speakerName,
                        style: TextStyle(
                          color: palette.onCard,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    if (role case final speakerRole?
                        when speakerRole.isNotEmpty)
                      Text(
                        speakerRole,
                        style: TextStyle(color: palette.muted, fontSize: 13),
                      ),
                  ],
                ),
              ),
              if (website.isNotEmpty)
                IconButton(
                  onPressed: () => _openWebsite(website),
                  icon: Icon(Icons.open_in_new, color: palette.muted, size: 18),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _openSpeaker(BuildContext context, String speakerId) {
    final conference = speaker.conferenceKey.isNotEmpty
        ? speaker.conferenceKey
        : track.conferenceKey;
    context.pushNamed(
      '${Pages.schedule.nameKey}-${SpeakerDetailsPage.routeNameKey}',
      pathParameters: {'id': speakerId},
      queryParameters: {'conference': conference},
    );
  }
}

class _DescriptionCard extends StatelessWidget {
  const _DescriptionCard({required this.html, required this.plain});

  final String html;
  final String plain;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final style = TextStyle(color: palette.onCard, fontSize: 15, height: 1.45);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: palette.hairline),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: html.isNotEmpty
            ? HtmlWidget(
                html,
                factoryBuilder: CachingHtmlWidgetFactory.new,
                textStyle: style,
              )
            : Text(plain, style: style),
      ),
    );
  }
}

void _openWebsite(String url) {
  if (Uri.tryParse(url) case final uri?) {
    launchUrl(uri, mode: .externalApplication);
  }
}

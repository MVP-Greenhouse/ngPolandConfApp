import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/core/utils/network_photo_url.dart';
import 'package:ng_poland_conf_app/features/edition/domains/logic/edition_projections.dart';
import 'package:ng_poland_conf_app/features/event/presentation/cubit/event_cubit.dart';
import 'package:ng_poland_conf_app/features/event/presentation/widgets/event_vote_button.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/entities/event_item.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/logic/conference_datetime.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/entities/speaker.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/widgets/speaker_details.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/routing/routing.dart';
import 'package:ng_poland_conf_app/theme/app_palette.dart';
import 'package:ng_poland_conf_app/widgets/caching_html_widget_factory.dart';
import 'package:ng_poland_conf_app/widgets/custom_back_button.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';
import 'package:ng_poland_conf_app/widgets/simple_cross_origin_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../settings/presentation/connection_status.dart';

class EventPage extends StatefulWidget {
  static const routeName = 'event';
  static const routeNameKey = 'EventPage';

  final String eventId;
  final String eventItemType;

  const EventPage({
    super.key,
    required this.eventId,
    required this.eventItemType,
  });

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  late final EventCubit _eventCubit;

  @override
  void initState() {
    super.initState();
    _eventCubit = getIt.get<EventCubit>()
      ..getData(eventId: widget.eventId, eventItemType: widget.eventItemType);
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return CustomScaffold(
      showDrawer: false,
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text(
          'Event',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        actions: const [ConnectionStatus()],
      ),
      body: ColoredBox(
        color: palette.screen,
        child: BlocBuilder<EventCubit, EventState>(
          bloc: _eventCubit,
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (eventItem) => _EventBody(
                eventItem: eventItem,
                eventId: widget.eventId,
                eventItemType: widget.eventItemType,
              ),
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}

class _EventBody extends StatelessWidget {
  const _EventBody({
    required this.eventItem,
    required this.eventId,
    required this.eventItemType,
  });

  final EventItem eventItem;
  final String eventId;
  final String eventItemType;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final speakers = _speakersOf(eventItem);
    final session = eventItem.sessionLabel.trim();
    final descriptionHtml = eventItem.descriptionHtml.trim();
    final description = eventItem.description?.trim() ?? '';
    final time = _timeLabel(eventItem);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
      children: [
        if (time.isNotEmpty)
          Text(
            time,
            style: TextStyle(
              color: palette.muted,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        const SizedBox(height: 6),
        Text(
          eventItem.title,
          style: TextStyle(
            color: palette.onCard,
            fontSize: 26,
            height: 1.2,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (session.isNotEmpty) ...[
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: _SessionChip(label: session),
          ),
        ],
        if (speakers.isNotEmpty) ...[
          const SizedBox(height: 18),
          for (final speaker in speakers) ...[
            _SpeakerCard(speaker: speaker, eventItemType: eventItemType),
            const SizedBox(height: 12),
          ],
        ],
        if (eventItem.hasSpeaker && !eventItem.isBreak) ...[
          EventVoteButtonHost(eventId: eventId, eventItemType: eventItemType),
          const SizedBox(height: 12),
        ],
        if (_hasVisibleCopy(html: descriptionHtml, plain: description))
          _DescriptionCard(html: descriptionHtml, plain: description),
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
  const _SpeakerCard({required this.speaker, required this.eventItemType});

  final Speaker speaker;
  final String eventItemType;

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
    final track = EventItemType.values.asNameMap()[eventItemType];
    final conference = speaker.conferenceKey.isNotEmpty
        ? speaker.conferenceKey
        : track == null
        ? ''
        : conferenceKeyForTrack(track);
    context.pushNamed(
      '${Pages.schedule.nameKey}-${SpeakerDetails.routeNameKey}',
      pathParameters: {'id': speakerId},
      queryParameters: {if (conference.isNotEmpty) 'conference': conference},
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

List<Speaker> _speakersOf(EventItem eventItem) {
  if (eventItem.speakers.isNotEmpty) return eventItem.speakers;
  final speaker = eventItem.speaker;
  if (speaker == null) return const [];
  return [speaker];
}

bool _hasVisibleCopy({required String html, required String plain}) {
  if (plain.isNotEmpty) return true;
  final text = html
      .replaceAll(RegExp(r'<[^>]*>'), ' ')
      .replaceAll('&nbsp;', ' ')
      .replaceAll(RegExp(r'&\w+;'), ' ')
      .trim();
  return text.isNotEmpty;
}

String _timeLabel(EventItem event) {
  if (event.timeLabel.isNotEmpty) return event.timeLabel;
  final start = ConferenceDateTime.formatHm(event.startDate);
  final end = ConferenceDateTime.formatHm(event.endDate);
  if (start.isEmpty) return '';
  if (end.isEmpty) return start;
  return '$start – $end';
}

void _openWebsite(String url) {
  final uri = Uri.tryParse(url);
  if (uri == null) return;
  launchUrl(uri, mode: LaunchMode.externalApplication);
}

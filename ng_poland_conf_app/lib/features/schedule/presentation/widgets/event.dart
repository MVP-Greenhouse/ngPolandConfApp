import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/core/utils/network_photo_url.dart';
import 'package:ng_poland_conf_app/features/event/presentation/event_page.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/entities/event_item.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/logic/conference_datetime.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/widgets/agenda_icon.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/entities/speaker.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/widgets/speaker_details.dart';
import 'package:ng_poland_conf_app/routing/routing.dart';
import 'package:ng_poland_conf_app/theme/app_palette.dart';
import 'package:ng_poland_conf_app/widgets/simple_cross_origin_image.dart';

class ScheduleEvent extends StatelessWidget {
  const ScheduleEvent({
    super.key,
    required this.eventItem,
    required this.eventItemType,
    required this.isActiveEvent,
  });

  final EventItem eventItem;
  final EventItemType eventItemType;
  final bool isActiveEvent;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final speakers = eventItem.speakers.isNotEmpty
        ? eventItem.speakers
        : [?eventItem.speaker];
    final highlighted = isActiveEvent;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Opacity(
        opacity: eventItem.isBreak ? 0.72 : 1,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: eventItem.hasSpeaker ? () => _openEvent(context) : null,
            borderRadius: BorderRadius.circular(22),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: highlighted
                      ? palette.accent.withValues(alpha: 0.85)
                      : palette.hairline,
                ),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    palette.card,
                    highlighted
                        ? palette.accent.withValues(alpha: 0.16)
                        : palette.card,
                  ],
                ),
                boxShadow: [
                  if (highlighted)
                    BoxShadow(
                      color: palette.accent.withValues(alpha: 0.28),
                      blurRadius: 22,
                    ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 14, 16),
                child: _ScheduleCardBody(
                  eventItem: eventItem,
                  speakers: speakers,
                  highlighted: highlighted,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openEvent(BuildContext context) {
    context.pushNamed(
      '${Pages.schedule.nameKey}-${EventPage.routeNameKey}',
      pathParameters: {
        'eventId': eventItem.id,
        'eventItemType': eventItemType.name,
      },
    );
  }
}

class _ScheduleCardBody extends StatelessWidget {
  const _ScheduleCardBody({
    required this.eventItem,
    required this.speakers,
    required this.highlighted,
  });

  final EventItem eventItem;
  final List<Speaker> speakers;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final time = _timeLabel(eventItem);
    final note = _cardNote(eventItem);
    final session = eventItem.sessionLabel.trim();
    final showSessionChip = speakers.isNotEmpty && session.isNotEmpty;
    final duration = speakers.isNotEmpty && !eventItem.isBreak
        ? scheduleDurationLabel(eventItem.startDate, eventItem.endDate)
        : null;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  fontSize: 18,
                  height: 1.25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (speakers.isNotEmpty) ...[
                const SizedBox(height: 14),
                for (final speaker in speakers) ...[
                  _ScheduleSpeakerTile(speaker: speaker),
                  const SizedBox(height: 10),
                ],
              ] else if (session.isNotEmpty || note != null) ...[
                const SizedBox(height: 12),
                _ScheduleMetaRow(
                  sessionLabel: session,
                  note: note,
                  iconName: eventItem.icon,
                  category: eventItem.category,
                ),
              ],
              if (showSessionChip || duration != null) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if (showSessionChip) _TopicChip(label: session),
                    if (duration case final length?)
                      _DurationChip(label: length),
                  ],
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: 12),
        _ScheduleIconBadge(
          iconName: eventItem.icon,
          category: eventItem.category,
          highlighted: highlighted,
        ),
      ],
    );
  }
}

class _ScheduleIconBadge extends StatelessWidget {
  const _ScheduleIconBadge({
    required this.iconName,
    required this.category,
    required this.highlighted,
  });

  final String iconName;
  final String category;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: highlighted ? palette.accent : palette.panel,
        borderRadius: BorderRadius.circular(14),
      ),
      child: SizedBox(
        width: 44,
        height: 44,
        child: Center(
          child: FaIcon(
            agendaIcon(iconName, category),
            size: 16,
            color: highlighted ? palette.onAccent : palette.muted,
          ),
        ),
      ),
    );
  }
}

class _ScheduleSpeakerTile extends StatelessWidget {
  const _ScheduleSpeakerTile({required this.speaker});

  final Speaker speaker;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final photoFileUrl = networkPhotoUrl(speaker.photoFileUrl);
    final name = speaker.name;
    final role = speaker.role;

    return InkWell(
      onTap: () => context.pushNamed(
        '${Pages.schedule.nameKey}-${SpeakerDetails.routeNameKey}',
        pathParameters: {'id': speaker.id ?? ''},
        queryParameters: {
          if (speaker.conferenceKey.isNotEmpty)
            'conference': speaker.conferenceKey,
        },
      ),
      borderRadius: BorderRadius.circular(12),
      child: Row(
        children: [
          ClipOval(
            child: photoFileUrl.isEmpty
                ? Image.asset(
                    'assets/images/person.png',
                    width: 36,
                    height: 36,
                    fit: BoxFit.cover,
                  )
                : SimpleCrossOriginImage(
                    imageUrl: photoFileUrl,
                    width: 36,
                    height: 36,
                    placeholderAsset: 'assets/images/person.png',
                  ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (name case final speakerName? when speakerName.isNotEmpty)
                  Text(
                    speakerName,
                    style: TextStyle(
                      color: palette.onCard,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                if (role case final speakerRole? when speakerRole.isNotEmpty)
                  Text(
                    speakerRole,
                    style: TextStyle(color: palette.muted, fontSize: 12),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScheduleMetaRow extends StatelessWidget {
  const _ScheduleMetaRow({
    required this.sessionLabel,
    required this.note,
    required this.iconName,
    required this.category,
  });

  final String sessionLabel;
  final String? note;
  final String iconName;
  final String category;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (sessionLabel.isNotEmpty)
          _MetaItem(
            icon: Icon(
              Icons.meeting_room_outlined,
              size: 14,
              color: palette.muted,
            ),
            label: sessionLabel,
            color: palette.muted,
          ),
        if (note case final text?) ...[
          if (sessionLabel.isNotEmpty) const SizedBox(height: 6),
          _MetaItem(
            icon: FaIcon(
              agendaIcon(iconName, category),
              size: 12,
              color: palette.accent,
            ),
            label: text,
            color: palette.accent,
          ),
        ],
      ],
    );
  }
}

class _MetaItem extends StatelessWidget {
  const _MetaItem({
    required this.icon,
    required this.label,
    required this.color,
  });

  final Widget icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: color, fontSize: 12, height: 1.3),
          ),
        ),
      ],
    );
  }
}

class _TopicChip extends StatelessWidget {
  const _TopicChip({required this.label});

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

class _DurationChip extends StatelessWidget {
  const _DurationChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.panel,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          label,
          style: TextStyle(
            color: palette.muted,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

String _timeLabel(EventItem event) {
  if (event.timeLabel.isNotEmpty) return event.timeLabel;
  final start = ConferenceDateTime.formatHm(event.startDate);
  final end = ConferenceDateTime.formatHm(event.endDate);
  if (start.isEmpty) return '';
  if (end.isEmpty) return start;
  return '$start – $end';
}

String? _cardNote(EventItem event) {
  final description = event.description?.trim() ?? '';
  if (description.isEmpty ||
      description.length > 72 ||
      description.contains('\n')) {
    return null;
  }
  if (description == event.sessionLabel.trim()) return null;
  return description;
}

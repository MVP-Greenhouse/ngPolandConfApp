import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/core/blocks/themeMode/theme_mode_cubit.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/event/presentation/event_page.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/entities/event_item.dart';
import 'package:ng_poland_conf_app/core/utils/network_photo_url.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/logic/conference_datetime.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/widgets/agenda_icon.dart';
import 'package:ng_poland_conf_app/features/schedule/presentation/widgets/highlight_shadow.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/entities/speaker.dart';

import '../../../../routing/routing.dart';
import '../../../../widgets/simple_cross_origin_image.dart';
import '../../../speakers/presentation/widgets/speaker_details.dart';

class ScheduleEvent extends StatefulWidget {
  final EventItem eventItem;
  final EventItemType eventItemType;
  final Color iconColor;
  final bool isActiveEvent;

  const ScheduleEvent({
    super.key,
    required this.eventItem,
    required this.eventItemType,
    required this.iconColor,
    required this.isActiveEvent,
  });

  @override
  State<ScheduleEvent> createState() => _ScheduleEventState();
}

class _ScheduleEventState extends State<ScheduleEvent>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => widget.isActiveEvent;

  Widget _getIcon() {
    return FaIcon(
      agendaIcon(widget.eventItem.icon, widget.eventItem.category),
      color: widget.iconColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final timeLabel = widget.eventItem.timeLabel;
    final speakers = widget.eventItem.speakers.isNotEmpty
        ? widget.eventItem.speakers
        : [if (widget.eventItem.speaker case final speaker?) speaker];

    return Opacity(
      opacity: widget.eventItem.isBreak ? 0.55 : 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            BlocBuilder<ThemeModeCubit, ThemeModeState>(
              builder: (_, state) {
                return HighlightShadow(
                  isDarkMode: state.isDarkMode,
                  animate: widget.isActiveEvent,
                  child: _listElement(context, timeLabel, speakers),
                );
              },
            ),
            Divider(
              color: Theme.of(context).dividerTheme.color?.withOpacity(0.2),
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget _listElement(
    BuildContext context,
    String timeLabel,
    List<Speaker> speakers,
  ) {
    return ListTile(
      leading: Text(
        timeLabel.isNotEmpty
            ? timeLabel
            : ConferenceDateTime.formatHm(widget.eventItem.startDate),
        style: TextStyle(
          fontSize: 12,
          color: Theme.of(context).textTheme.bodySmall?.color,
        ),
      ),
      title: _buildButton(
        onPressed: widget.eventItem.hasSpeaker
            ? () => context.pushNamed(
                '${Pages.schedule.nameKey}-${EventPage.routeNameKey}',
                pathParameters: {
                  'eventId': widget.eventItem.id,
                  'eventItemType': widget.eventItemType.name,
                },
              )
            : null,
        child: Text(
          widget.eventItem.title,
          style: TextStyle(
            color: Theme.of(
              context,
            ).textTheme.bodySmall?.color?.withOpacity(0.8),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [for (final speaker in speakers) _buildSpeaker(speaker)],
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Opacity(opacity: 0.7, child: _getIcon())],
      ),
    );
  }

  Widget _buildSpeaker(Speaker speaker) {
    final photoFileUrl = networkPhotoUrl(speaker.photoFileUrl);
    final name = speaker.name;
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: _buildButton(
        onPressed: () => context.pushNamed(
          '${Pages.schedule.nameKey}-${SpeakerDetails.routeNameKey}',
          pathParameters: {'id': speaker.id ?? ''},
          queryParameters: {
            if (speaker.conferenceKey.isNotEmpty)
              'conference': speaker.conferenceKey,
          },
        ),
        child: Wrap(
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10,
          children: [
            if (photoFileUrl.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: SimpleCrossOriginImage(
                  imageUrl: photoFileUrl,
                  width: 20,
                  placeholderAsset: 'assets/images/person.png',
                ),
              ),
            if (name != null) Text(name, style: const TextStyle(fontSize: 13)),
            if (speaker.role case final role? when role.isNotEmpty)
              Text(role, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required VoidCallback? onPressed,
    required Widget child,
  }) {
    return Container(
      alignment: Alignment.centerLeft,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          alignment: Alignment.centerLeft,
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

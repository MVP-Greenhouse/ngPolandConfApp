import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/event/presentation/event_page.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/entities/event_item.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/entities/speaker.dart';

import '../../../../routing/routing.dart';
import '../../../speakers/presentation/widgets/speaker_details.dart';

class ScheduleEvent extends StatefulWidget {
  final EventItem eventItem;
  final EventItemType eventItemType;
  final Color iconColor;

  const ScheduleEvent(
    this.eventItem,
    this.eventItemType,
    this.iconColor, {
    super.key,
  });

  @override
  State<ScheduleEvent> createState() => _ScheduleEventState();
}

class _ScheduleEventState extends State<ScheduleEvent> {
  Widget _getIcon(String? category) {
    var icon = switch (category) {
      'registration' => FontAwesomeIcons.addressCard,
      'welcome' => FontAwesomeIcons.child,
      'presentation' => FontAwesomeIcons.microphone,
      'eating' => FontAwesomeIcons.utensils,
      'award' => FontAwesomeIcons.trophy,
      'break' => FontAwesomeIcons.solidComments,
      'final' => FontAwesomeIcons.doorOpen,
      _ => null,
    };

    return Icon(
      icon,
      color: widget.iconColor,
    );
  }

  late Timer _timer;

  bool _animation = false;

  @override
  void initState() {
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (Timer timer) => setState(() {
        _animation = !_animation;
      }),
    );

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  bool checkTimeEventToAnimation(
    DateTime dateNow,
    String dateStartEvent,
    String dateEndEvent,
  ) {
    return DateTime.parse(dateStartEvent).toLocal().millisecondsSinceEpoch < dateNow.millisecondsSinceEpoch &&
        dateNow.millisecondsSinceEpoch < DateTime.parse(dateEndEvent).toLocal().millisecondsSinceEpoch;
  }

  @override
  Widget build(BuildContext context) {
    final DateTime? startDate = widget.eventItem.startDate;
    final DateTime? endDate = widget.eventItem.endDate;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          _listElement(context, startDate, endDate),
          Divider(
            color: Theme.of(context).dividerTheme.color?.withOpacity(0.2),
            height: 40,
          ),
        ],
      ),
    );
  }

  Widget _listElement(BuildContext context, DateTime? startDate, DateTime? endDate) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (startDate != null)
            Text(
              DateFormat.Hm().format(startDate),
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
          if (endDate != null)
            Text(
              DateFormat.Hm().format(endDate),
              style: const TextStyle(fontSize: 12),
            ),
        ],
      ),
      title: _buildButton(
        onPressed: widget.eventItem.speaker == null
            ? null
            : () => context.pushNamed(
                  '${Pages.schedule.nameKey}-${EventPage.routeNameKey}',
                  pathParameters: {
                    'eventId': widget.eventItem.id,
                    'eventItemType': widget.eventItemType.name,
                  },
                ),
        child: Text(
          widget.eventItem.title,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.8),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      subtitle: _buildSpeaker(widget.eventItem.speaker),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Opacity(
            opacity: 0.7,
            child: _getIcon(widget.eventItem.category),
          ),
        ],
      ),
    );
  }

  Widget _buildSpeaker(Speaker? speaker) {
    final String? photoFileUrl = speaker?.photoFileUrl;
    final String? name = speaker?.name;
    return speaker == null
        ? const Text('')
        : Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: _buildButton(
              onPressed: () => context.pushNamed(
                '${Pages.schedule.nameKey}-${SpeakerDetails.routeNameKey}',
                pathParameters: {
                  'id': widget.eventItem.speaker?.id ?? '',
                },
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10,
                    children: [
                      if (photoFileUrl != null)
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          child: CachedNetworkImage(
                            width: 20,
                            progressIndicatorBuilder: (context, url, downloadProgress) => Image.asset('assets/images/person.png'),
                            imageUrl: 'https:${speaker.photoFileUrl}',
                            errorWidget: (context, url, dynamic error) {
                              return Image.asset('assets/images/person.png');
                            },
                          ),
                        ),
                      if (name != null)
                        Text(
                          name,
                          style: const TextStyle(
                            // color: _darkMode ? Theme.of(context).textTheme.bodyText1.color.withOpacity(0.7) : Theme.of(context).primaryColor,
                            fontSize: 13,
                          ),
                        ),
                    ],
                  ),
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
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 6.0,
          ),
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

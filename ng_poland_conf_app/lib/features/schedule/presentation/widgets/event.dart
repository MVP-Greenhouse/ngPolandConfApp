import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/entities/event_item.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/entities/speaker.dart';

class ScheduleEvent extends StatelessWidget {
  final EventItem eventItem;
  final Color iconColor;

  const ScheduleEvent(
    this.eventItem,
    this.iconColor, {
    super.key,
  });

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
      color: iconColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final DateTime? startDate = eventItem.startDate;
    final DateTime? endDate = eventItem.endDate;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          ListTile(
            onTap: eventItem.speaker == null
                ? null
                : () {
                    // Navigator.of(context).pushNamed(
                    //   Presenter.routeName,
                    //   arguments: {
                    //     'title': widget.eventItem.title,
                    //     'description': widget.eventItem.description,
                    //     'icon': _getIcon(
                    //       widget.eventItem.category,
                    //       _iconsColor,
                    //     ),
                    //     'speaker': widget.eventItem.speaker,
                    //   },
                    // );
                  },
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
            title: Text(
              eventItem.title,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.8),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: _buildSpeaker(eventItem.speaker),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Opacity(
                  opacity: 0.7,
                  child: _getIcon(eventItem.category),
                ),
              ],
            ),
          ),
          Divider(
            color: Theme.of(context).dividerTheme.color?.withOpacity(0.2),
            height: 20,
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
            padding: const EdgeInsets.only(top: 8.0),
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
                      Hero(
                        tag: photoFileUrl,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          child: CachedNetworkImage(
                            width: 20,
                            progressIndicatorBuilder: (context, url, downloadProgress) => Image.asset('assets/images/person.png'),
                            imageUrl: 'http:${speaker.photoFileUrl}',
                            errorWidget: (context, url, dynamic error) {
                              return Image.asset('assets/images/person.png');
                            },
                          ),
                        ),
                      ),
                    if (name != null)
                      Text(
                        name,
                        style: TextStyle(
                            // color: _darkMode ? Theme.of(context).textTheme.bodyText1.color.withOpacity(0.7) : Theme.of(context).primaryColor,
                            fontSize: 13),
                      ),
                  ],
                ),
              ],
            ),
          );
  }
}

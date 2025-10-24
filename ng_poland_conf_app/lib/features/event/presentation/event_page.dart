import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ng_poland_conf_app/core/mixins/connectivity_mixin.dart';
import 'package:ng_poland_conf_app/features/event/presentation/cubit/event_cubit.dart';
import 'package:ng_poland_conf_app/features/event/presentation/widgets/event_rating.dart';
import 'package:ng_poland_conf_app/features/schedule/domains/entities/event_item.dart';
import 'package:ng_poland_conf_app/features/speakers/domains/entities/speaker.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';
import 'package:rive/rive.dart' as rive;
import 'package:url_launcher/url_launcher.dart';

import '../../../widgets/cross_origin_image.dart';
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

class _EventPageState extends State<EventPage> with ConnectivityMixin {
  late final EventCubit _eventCubit;
  late final rive.RiveFile ratingFile;

  @override
  void initState() {
    rootBundle.load(EventRating.ratingFilePath).then(
      (data) async {
        ratingFile = rive.RiveFile.import(data);
      },
    );
    _eventCubit = getIt.get<EventCubit>()
      ..getData(
        eventId: widget.eventId,
        eventItemType: widget.eventItemType,
      );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showDrawer: false,
      appBar: AppBar(
        title: Text(
          'Event',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        actions: const [
          ConnectionStatus(),
        ],
      ),
      body: BlocBuilder<EventCubit, EventState>(
        bloc: _eventCubit,
        builder: (context, state) {
          return state.maybeWhen(
            loaded: (eventItem) {
              return SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      _buildSpeaker(eventItem.speaker),
                      _buildEventInfo(eventItem),
                    ],
                  ),
                ),
              );
            },
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }

  Widget _buildEventInfo(EventItem eventItem) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            eventItem.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.9),
                ),
            textAlign: TextAlign.center,
          ),
        ),
        // BlocBuilder<ConferencesCubit, ConferencesState>(
        //   builder: (context, state) {
        //     return state.isCurrent
        //         ? EventRating(
        //             id: widget.eventId,
        //             ratingFile: ratingFile,
        //             eventItemType: widget.eventItemType,
        //           )
        //         : const SizedBox.shrink();
        //   },
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Container(
            alignment: Alignment.centerLeft,
            child: eventItem.description != null
                ? Container(
                    alignment: Alignment.centerLeft,
                    child: Text(eventItem.description ?? '',
                        style: Theme.of(context).textTheme.bodySmall),
                  )
                : Container(
                    padding: const EdgeInsets.only(top: 40, bottom: 20),
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: double.infinity,
                    child: const FittedBox(
                      child: Opacity(
                          opacity: 0.1, child: Icon(Icons.question_mark)),
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildSpeaker(Speaker? speaker) {
    if (speaker == null) return const SizedBox.shrink();
    final flatButtonStyle = TextButton.styleFrom(
      foregroundColor: Colors.black87,
      minimumSize: const Size(50, 50),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0),
      ),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            speaker.name as String,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 18.0,
                ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Stack(
              children: [
                Center(
                  child: CrossOriginImage(
                    imageUrl: 'https:${speaker.photoFileUrl}',
                    placeholderAsset: 'assets/images/person.png',
                    sizeFactor: 0.2,
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  margin: const EdgeInsets.only(right: 20.0),
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.width * 0.30
                          : MediaQuery.of(context).size.width * 0.37,
                  width:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? null
                          : MediaQuery.of(context).size.width * 0.33,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: TextButton(
                      style: flatButtonStyle,
                      onPressed: () {
                        speaker.urlTwitter != null
                            ? launchUrl(Uri.parse(speaker.urlTwitter as String))
                            : null;
                      },
                      child: const Icon(
                        FontAwesomeIcons.twitter,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

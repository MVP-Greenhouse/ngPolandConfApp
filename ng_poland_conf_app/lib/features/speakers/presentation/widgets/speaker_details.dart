import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../injectable.dart';
import '../../../../widgets/empty_list_info.dart';
import '../../domains/entities/speaker.dart';
import '../cubit/speakers_cubit.dart';

class SpeakerDetails extends StatefulWidget {
  final String id;

  const SpeakerDetails({super.key, required this.id});

  static const routeName = 'deatils';
  static const routeNameKey = 'SpeakerDetails';

  @override
  State<SpeakerDetails> createState() => _SpeakerDetailsState();
}

class _SpeakerDetailsState extends State<SpeakerDetails> {
  late final SpeakersCubit _speakersCubit;

  @override
  void initState() {
    _speakersCubit = getIt.get<SpeakersCubit>();

    _speakersCubit.getListSpeakers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final flatButtonStyle = TextButton.styleFrom(
      foregroundColor: Colors.black87,
      minimumSize: const Size(50, 50),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0),
      ),
    );

    // Speaker _speaker = _data['speaker'] as Speaker;

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        onPressed: () {
          GoRouter.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_ios),
        //replace with our own icon data.
      )),
      body: BlocBuilder<SpeakersCubit, SpeakersState>(
          bloc: _speakersCubit,
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              loaded: (listSpeakers) {
                final speaker = listSpeakers.firstWhere((element) {
                  return element.id == widget.id;
                }, orElse: () => Speaker.empty);
                return speaker.id == Speaker.empty.id
                    ? const EmptyListInformation()
                    : SingleChildScrollView(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Text(
                                  speaker.name as String,
                                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                        color: Theme.of(context).colorScheme.tertiary,
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
                                        child: CachedNetworkImage(
                                          progressIndicatorBuilder: (context, url, downloadProgress) => Image.asset('assets/images/person.png'),
                                          imageUrl: 'http:${speaker.photoFileUrl}',
                                          errorWidget: (context, url, dynamic error) {
                                            return Image.asset('assets/images/person.png');
                                          },
                                          imageBuilder: (context, imageProvider) => SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.4,
                                            height: MediaQuery.of(context).size.width * 0.4,
                                            child: CircleAvatar(
                                              radius: 25,
                                              backgroundImage: imageProvider,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).orientation == Orientation.portrait
                                            ? MediaQuery.of(context).size.width * 0.40
                                            : MediaQuery.of(context).size.width * 0.37,
                                        width: MediaQuery.of(context).orientation == Orientation.portrait ? null : MediaQuery.of(context).size.width * 0.43,
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.white,
                                            child: TextButton(
                                              style: flatButtonStyle,
                                              onPressed: () {
                                                // launch(speaker.urlTwitter);
                                              },
                                              child: const Icon(
                                                FontAwesomeIcons.twitter,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.02,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  speaker.role ?? '',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.9),
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: speaker.bio != null
                                      ? Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(speaker.bio ?? '', style: Theme.of(context).textTheme.bodySmall),
                                        )
                                      : Container(
                                          padding: const EdgeInsets.only(top: 40, bottom: 20),
                                          height: MediaQuery.of(context).size.height * 0.2,
                                          width: double.infinity,
                                          child: const FittedBox(
                                            child: Opacity(opacity: 0.1, child: Icon(Icons.question_mark)),
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
              },
              orElse: () => const SizedBox.shrink(),
            );
          }),
    );
  }
}

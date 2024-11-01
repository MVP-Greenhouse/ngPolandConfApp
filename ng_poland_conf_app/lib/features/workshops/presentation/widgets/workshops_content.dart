import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../routing/routing.dart';
import '../../../speakers/presentation/widgets/speaker_details.dart';
import '../../domains/entities/workshop.dart';

class WorkshopsContent extends StatelessWidget {
  final Workshop workshop;

  const WorkshopsContent({
    Key? key,
    required this.workshop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ListTile(
            leading: InkWell(
              borderRadius: const BorderRadius.all(
                Radius.circular(25),
              ),
              onTap: () {
                context.pushNamed('${Pages.workshops.nameKey}-${SpeakerDetails.routeNameKey}', pathParameters: {
                  'id': workshop.speaker.id ?? '',
                });
              },
              child: CachedNetworkImage(
                progressIndicatorBuilder: (context, url, downloadProgress) => Image.asset(
                  'assets/images/person.png',
                  width: 50,
                  height: 50,
                ),
                imageUrl: 'https:${workshop.speaker.photoFileUrl}',
                errorWidget: (context, url, dynamic error) {
                  return Image.asset('assets/images/person.png', width: 50, height: 50);
                },
                imageBuilder: (context, imageProvider) => Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                    ),
                  ),
                ),
              ),
            ),
            title: SelectableText(
              workshop.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.010,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: workshop.speaker.name,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).textTheme.titleSmall?.color?.withOpacity(0.7)),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.pushNamed('${Pages.workshops.nameKey}-${SpeakerDetails.routeNameKey}', pathParameters: {
                                'id': workshop.speaker.id ?? '',
                              });
                            }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.025,
          ),
          SelectableText(
            workshop.description ?? '',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.035,
          ),
          Divider(
            height: 0,
            color: Theme.of(context).dividerTheme.color,
          )
        ],
      ),
    );
  }
}

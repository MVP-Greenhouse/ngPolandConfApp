import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/widgets/speaker_details.dart';
import '../../../../routing/routing.dart';
import '../../../../widgets/fixed_size_cross_origin_image.dart';
import '../../domains/entities/speaker.dart';

class SpeakerTile extends StatelessWidget {
  const SpeakerTile(this.speaker, {super.key});

  final Speaker speaker;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              context.pushNamed(
                  '${Pages.speakers.nameKey}-${SpeakerDetails.routeNameKey}',
                  pathParameters: {
                    'id': speaker.id ?? '',
                  });
            },
            leading: InkWell(
              borderRadius: const BorderRadius.all(
                Radius.circular(25),
              ),
              child: FixedSizeCrossOriginImage(
                imageUrl: 'https:${speaker.photoFileUrl}',
                size: 50.0, // Setting the fixed size
                placeholderAsset: 'assets/images/person.png',
              ),
            ),
            title: Text(
              speaker.name ?? '',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  speaker.role ?? '',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.color
                            ?.withOpacity(0.7),
                      ),
                ),
              ],
            ),
          ),
          Divider(
            height: 60,
            color: Theme.of(context).dividerTheme.color,
          )
        ],
      ),
    );
  }
}

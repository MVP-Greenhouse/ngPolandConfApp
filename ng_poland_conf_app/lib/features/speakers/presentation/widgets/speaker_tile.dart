import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/core/presentation/navigation/app_pages.dart';
import 'package:ng_poland_conf_app/core/presentation/theme/app_palette.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/fixed_size_cross_origin_image.dart';
import 'package:ng_poland_conf_app/core/utils/hex_color.dart';
import 'package:ng_poland_conf_app/core/utils/network_photo_url.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/speaker.dart';
import 'package:ng_poland_conf_app/features/speakers/domain/entities/speaker_list_item.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/pages/speaker_details_page.dart';

class SpeakerTile extends StatelessWidget {
  const SpeakerTile(this.item, {super.key});

  final SpeakerListItem item;

  Speaker get speaker => item.speaker;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final position = item.position;
    final company = item.company;
    final accent = colorFromHex(item.color) ?? palette.accent;
    final role = speaker.role ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Material(
        color: palette.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: palette.hairline),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => _openSpeaker(context),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
            child: Column(
              children: [
                Row(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: accent, width: 2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: SizedBox(
                          width: 56,
                          height: 56,
                          child: FixedSizeCrossOriginImage(
                            imageUrl: networkPhotoUrl(speaker.photoFileUrl),
                            size: 56,
                            placeholderAsset: 'assets/images/person.png',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            speaker.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: palette.onCard,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          if (position.isNotEmpty ||
                              company.isNotEmpty ||
                              role.isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Text.rich(
                              TextSpan(
                                children: [
                                  if (position.isNotEmpty)
                                    TextSpan(
                                      text: position,
                                      style: TextStyle(
                                        color: palette.accent,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  if (position.isNotEmpty && company.isNotEmpty)
                                    TextSpan(
                                      text: '  •  ',
                                      style: TextStyle(color: palette.muted),
                                    ),
                                  if (company.isNotEmpty)
                                    TextSpan(
                                      text: company,
                                      style: TextStyle(color: palette.muted),
                                    ),
                                  if (position.isEmpty &&
                                      company.isEmpty &&
                                      role.isNotEmpty)
                                    TextSpan(
                                      text: role,
                                      style: TextStyle(
                                        color: palette.accent,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                ],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                for (final session in item.sessions) ...[
                  const SizedBox(height: 10),
                  _SessionRow(
                    session: session,
                    onTap: () => _openSpeaker(context),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openSpeaker(BuildContext context) {
    final id = speaker.id;
    if (id == null || id.isEmpty) return;
    context.pushNamed(
      '${Pages.speakers.nameKey}-${SpeakerDetailsPage.routeNameKey}',
      pathParameters: {'id': id},
      queryParameters: {
        if (speaker.conferenceKey.isNotEmpty)
          'conference': speaker.conferenceKey,
      },
    );
  }
}

class _SessionRow extends StatelessWidget {
  const _SessionRow({required this.session, required this.onTap});

  final SpeakerSession session;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final highlighted = session.kind != .talk;
    final kind = switch (session.kind) {
      .talk => 'TALK',
      .keynote => 'KEYNOTE',
      .qa => 'Q&A',
    };
    final badgeColor = highlighted ? palette.accent : palette.chip;
    final badgeForeground = highlighted ? palette.onAccent : palette.onChip;
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: palette.hairline),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 6, 8),
          child: Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Text(
                    kind,
                    style: TextStyle(
                      color: badgeForeground,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  session.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: palette.onCard, fontSize: 13),
                ),
              ),
              Icon(Icons.chevron_right, color: palette.muted, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

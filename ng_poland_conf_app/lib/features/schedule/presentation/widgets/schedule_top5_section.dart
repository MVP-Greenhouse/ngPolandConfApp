import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/core/constants/event_types.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/event_vote_ranking.dart';
import 'package:ng_poland_conf_app/features/event/presentation/event_page.dart';
import 'package:ng_poland_conf_app/routing/routing.dart';
import 'package:ng_poland_conf_app/theme/app_palette.dart';

class ScheduleTop5Section extends StatelessWidget {
  const ScheduleTop5Section({
    super.key,
    required this.top,
    required this.track,
    required this.votingOpen,
    this.myLikedEventIds = const <String>{},
    this.onVote,
  });

  final List<EventVoteRank> top;
  final EventItemType track;
  final bool votingOpen;
  final Set<String> myLikedEventIds;
  final ValueChanged<String>? onVote;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _VotingInfoCard(votingOpen: votingOpen),
          const SizedBox(height: 20),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'LIVE RESULTS — ',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                    color: palette.muted,
                  ),
                ),
                TextSpan(
                  text: 'TOP 5',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                    color: palette.accent,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          if (top.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text(
                votingOpen
                    ? 'No votes in this track yet. Like talks to see them in the ranking.'
                    : 'No votes in this track.',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: palette.muted),
              ),
            )
          else
            for (var i = 0; i < top.length; i++) ...[
              if (i > 0) const SizedBox(height: 10),
              _RankingCard(
                place: i + 1,
                entry: top[i],
                track: track,
                votingOpen: votingOpen,
                likedByMe: myLikedEventIds.contains(top[i].eventId),
                onVote: switch (onVote) {
                  final vote? => () => vote(top[i].eventId),
                  null => null,
                },
              ),
            ],
        ],
      ),
    );
  }
}

class _VotingInfoCard extends StatelessWidget {
  const _VotingInfoCard({required this.votingOpen});

  final bool votingOpen;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    const closedAccent = Color(0xFFFFC107);

    final borderColor = votingOpen
        ? palette.accent.withValues(alpha: 0.55)
        : closedAccent.withValues(alpha: 0.45);
    final badgeColor = votingOpen ? palette.accent : closedAccent;
    final badgeForeground = votingOpen
        ? palette.onAccent
        : const Color(0xFF1A1200);
    final badgeLabel = votingOpen ? 'VOTING OPEN' : 'VOTING CLOSED';
    final title = votingOpen
        ? 'Vote for your favorite talks'
        : 'Final Top 5 results';
    final body = votingOpen
        ? 'Results update live. You can change your picks anytime.'
        : 'Voting is closed. Below is the official ranking of favorite talks.';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: palette.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor, width: 1.2),
        boxShadow: votingOpen
            ? null
            : [
                BoxShadow(
                  color: closedAccent.withValues(alpha: 0.12),
                  blurRadius: 14,
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (votingOpen)
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.7),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  )
                else
                  Icon(
                    Icons.emoji_events_rounded,
                    size: 13,
                    color: badgeForeground,
                  ),
                const SizedBox(width: 6),
                Text(
                  badgeLabel,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                    color: badgeForeground,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: palette.onCard,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 12,
              height: 1.35,
              color: palette.muted,
            ),
          ),
        ],
      ),
    );
  }
}

class _RankingCard extends StatelessWidget {
  const _RankingCard({
    required this.place,
    required this.entry,
    required this.track,
    required this.votingOpen,
    required this.likedByMe,
    this.onVote,
  });

  final int place;
  final EventVoteRank entry;
  final EventItemType track;
  final bool votingOpen;
  final bool likedByMe;
  final VoidCallback? onVote;

  bool get _isLeader => place == 1;

  void _openEvent(BuildContext context) {
    context.pushNamed(
      '${Pages.schedule.nameKey}-${EventPage.routeNameKey}',
      pathParameters: {'eventId': entry.eventId, 'eventItemType': track.name},
    );
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _openEvent(context),
        child: Ink(
          decoration: BoxDecoration(
            color: palette.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isLeader ? palette.accent : palette.hairline,
              width: _isLeader ? 1.6 : 1,
            ),
            boxShadow: _isLeader
                ? [
                    BoxShadow(
                      color: palette.accent.withValues(alpha: 0.28),
                      blurRadius: 16,
                    ),
                  ]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _RankBadge(place: place),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (entry.timeLabel.isNotEmpty) ...[
                            Text(
                              entry.timeLabel,
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: _isLeader
                                        ? palette.accent
                                        : palette.muted,
                                  ),
                            ),
                            const SizedBox(height: 4),
                          ],
                          Text(
                            entry.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  height: 1.25,
                                  color: palette.onCard,
                                ),
                          ),
                          if (entry.speakerName.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                _SpeakerAvatar(
                                  name: entry.speakerName,
                                  highlighted: _isLeader,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    entry.speakerName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          fontSize: 12,
                                          color: palette.muted,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, thickness: 1, color: palette.hairline),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
                child: _Footer(
                  isLeader: _isLeader,
                  likes: entry.likes,
                  votingOpen: votingOpen,
                  likedByMe: likedByMe,
                  onVote: onVote,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({
    required this.isLeader,
    required this.likes,
    required this.votingOpen,
    required this.likedByMe,
    this.onVote,
  });

  final bool isLeader;
  final int likes;
  final bool votingOpen;
  final bool likedByMe;
  final VoidCallback? onVote;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return Row(
      children: [
        if (isLeader) ...[
          const Icon(Icons.star_rounded, size: 16, color: Color(0xFFFFC107)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              'Ranking leader',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFFFC107),
              ),
            ),
          ),
          if (votingOpen)
            switch (onVote) {
              final vote? => _VoteButton(
                liked: likedByMe,
                likes: likes,
                showCount: true,
                onPressed: vote,
              ),
              null => const SizedBox.shrink(),
            },
        ] else ...[
          Expanded(
            child: Text(
              EventVoteRanking.voteCountLabel(likes),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 12,
                color: palette.muted,
              ),
            ),
          ),
          if (votingOpen)
            switch (onVote) {
              final vote? => _VoteButton(
                liked: likedByMe,
                likes: likes,
                showCount: false,
                onPressed: vote,
              ),
              null => const SizedBox.shrink(),
            },
        ],
      ],
    );
  }
}

class _RankBadge extends StatelessWidget {
  const _RankBadge({required this.place});

  final int place;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isLeader = place == 1;

    if (isLeader) {
      // Mockup: pink circle "1" with gold trophy on the top-right edge.
      return SizedBox(
        width: 42,
        height: 44,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: palette.accent,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: palette.accent.withValues(alpha: 0.45),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Text(
                  '$place',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: palette.onAccent,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const Positioned(
              top: -1,
              right: 0,
              child: Icon(
                Icons.emoji_events_rounded,
                size: 18,
                color: Color(0xFFFFC107),
                shadows: [Shadow(color: Color(0x80FFC107), blurRadius: 6)],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: 34,
      height: 34,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: palette.panel,
        border: Border.all(color: palette.hairline),
      ),
      child: Text(
        '$place',
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: palette.onCard,
          fontSize: 14,
        ),
      ),
    );
  }
}

class _SpeakerAvatar extends StatelessWidget {
  const _SpeakerAvatar({required this.name, required this.highlighted});

  final String name;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final initials = _initials(name);

    return CircleAvatar(
      radius: 11,
      backgroundColor: highlighted ? palette.accent : palette.chip,
      child: Text(
        initials,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w800,
          color: highlighted ? palette.onAccent : palette.onChip,
          height: 1,
        ),
      ),
    );
  }

  static String _initials(String name) {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      final value = parts.first;
      return value.substring(0, value.length.clamp(0, 2)).toUpperCase();
    }
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
}

class _VoteButton extends StatelessWidget {
  const _VoteButton({
    required this.liked,
    required this.likes,
    required this.showCount,
    required this.onPressed,
  });

  final bool liked;
  final int likes;
  final bool showCount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    if (liked) {
      final label = showCount ? 'Voted • $likes' : 'Voted';
      return Material(
        color: palette.accent,
        borderRadius: BorderRadius.circular(22),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(22),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.thumb_up_alt_rounded,
                  size: 14,
                  color: palette.onAccent,
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: palette.onAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Material(
      color: Colors.transparent,
      shape: StadiumBorder(side: BorderSide(color: palette.accent, width: 1.4)),
      child: InkWell(
        onTap: onPressed,
        customBorder: const StadiumBorder(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.thumb_up_alt_rounded, size: 13, color: palette.accent),
              const SizedBox(width: 5),
              Text(
                'Vote',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: palette.accent,
                ),
              ),
              const SizedBox(width: 4),
              const Text('👍', style: TextStyle(fontSize: 12, height: 1)),
            ],
          ),
        ),
      ),
    );
  }
}

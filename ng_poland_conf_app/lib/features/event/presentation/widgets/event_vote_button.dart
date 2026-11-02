import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/core/presentation/navigation/redirect_paths.dart';
import 'package:ng_poland_conf_app/core/presentation/theme/app_palette.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/app_notice.dart';
import 'package:ng_poland_conf_app/features/event/presentation/cubit/event_vote_cubit.dart';

class EventLikeButton extends StatelessWidget {
  const EventLikeButton({
    super.key,
    required this.liked,
    required this.enabled,
    required this.onTap,
  });

  final bool liked;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>();
    final colorScheme = Theme.of(context).colorScheme;
    final accent = palette?.accent ?? colorScheme.secondary;
    final onAccent = palette?.onAccent ?? colorScheme.onSecondary;
    final base = palette?.screen ?? colorScheme.surface;

    // Not liked yet: accent tint with an accent outline. Liked: solid accent,
    // so a cast vote stands out. Label and icon stay white in both states.
    // The fill is opaque because the button floats over the page content.
    final opacity = enabled ? 1.0 : 0.5;
    final tint = (liked ? 1.0 : 0.4) * opacity;
    final fillColor = Color.alphaBlend(accent.withValues(alpha: tint), base);
    final contentColor = onAccent.withValues(alpha: opacity);

    return SizedBox(
      height: 52,
      child: OutlinedButton.icon(
        key: const Key('event-vote-like'),
        onPressed: enabled ? onTap : null,
        style: OutlinedButton.styleFrom(
          backgroundColor: fillColor,
          foregroundColor: contentColor,
          disabledForegroundColor: contentColor,
          disabledBackgroundColor: fillColor,
          elevation: 6,
          shadowColor: Colors.black.withValues(alpha: 0.5),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          side: BorderSide(
            color: accent.withValues(alpha: opacity),
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
        ),
        icon: Icon(
          liked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
          color: contentColor,
          size: 22,
        ),
        label: Text(
          liked ? 'Liked' : 'Like this talk',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: contentColor,
          ),
        ),
      ),
    );
  }
}

/// Like button of a talk. Expects an [EventVoteCubit] above it.
class EventVoteSection extends StatelessWidget {
  const EventVoteSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventVoteCubit, EventVoteState>(
      listenWhen: (_, current) => current is VoteFailure,
      listener: (context, _) =>
          showAppNotice(context, AppNotice.voteUnavailable),
      builder: (context, state) {
        if (!state.showButton) return const SizedBox.shrink();
        return EventLikeButton(
          liked: state.liked,
          enabled: state is! VoteSaving,
          onTap: () => _onTap(context),
        );
      },
    );
  }

  void _onTap(BuildContext context) {
    final cubit = context.read<EventVoteCubit>();
    if (!cubit.requiresLogin) {
      cubit.toggleLike();
      return;
    }
    context.push(
      loginPath(from: internalLocationFromUri(GoRouterState.of(context).uri)),
    );
  }
}

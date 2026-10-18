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
    final background = palette?.card ?? colorScheme.surface;
    final foreground = palette?.onCard ?? colorScheme.onSurface;
    final accent = palette?.accent ?? colorScheme.secondary;
    final border = palette?.hairline ?? foreground.withValues(alpha: 0.12);
    final idleColor = liked ? accent : foreground;
    final contentColor = enabled ? idleColor : idleColor.withValues(alpha: 0.4);

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        key: const Key('event-vote-like'),
        onPressed: enabled ? onTap : null,
        style: OutlinedButton.styleFrom(
          backgroundColor: enabled
              ? background
              : background.withValues(alpha: 0.45),
          foregroundColor: contentColor,
          disabledForegroundColor: contentColor,
          disabledBackgroundColor: background.withValues(alpha: 0.45),
          side: BorderSide(
            color: enabled ? border : border.withValues(alpha: 0.4),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        icon: Icon(
          liked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
          color: contentColor,
          size: 18,
        ),
        label: Text(
          liked ? 'Liked' : 'Like talk',
          style: TextStyle(fontWeight: FontWeight.w600, color: contentColor),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/authentication_page.dart';
import 'package:ng_poland_conf_app/features/event/presentation/cubit/event_vote_cubit.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/routing/routing.dart';
import 'package:ng_poland_conf_app/theme/app_palette.dart';
import 'package:ng_poland_conf_app/widgets/app_notice.dart';

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

class EventVoteButtonHost extends StatefulWidget {
  const EventVoteButtonHost({
    super.key,
    required this.eventId,
    required this.eventItemType,
  });

  final String eventId;
  final String eventItemType;

  @override
  State<EventVoteButtonHost> createState() => _EventVoteButtonHostState();
}

class _EventVoteButtonHostState extends State<EventVoteButtonHost> {
  late final EventVoteCubit _cubit;

  @override
  void initState() {
    _cubit = getIt.get<EventVoteCubit>(
      param1: widget.eventId,
      param2: widget.eventItemType,
    );
    super.initState();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventVoteCubit, EventVoteState>(
      bloc: _cubit,
      listenWhen: (previous, current) =>
          current.maybeWhen(failure: (_) => true, orElse: () => false),
      listener: (context, state) {
        showAppNotice(context, AppNotice.voteUnavailable);
      },
      builder: (context, state) {
        if (!state.showButton) {
          return const SizedBox.shrink();
        }

        final enabled = state.maybeWhen(
          saving: (_) => false,
          orElse: () => true,
        );

        return EventLikeButton(
          liked: state.liked,
          enabled: enabled,
          onTap: () {
            if (_cubit.requiresLogin()) {
              context.push(
                AuthenticationPage.loginPath(
                  from: internalLocationFromUri(GoRouterState.of(context).uri),
                ),
              );
              return;
            }
            _cubit.toggleLike();
          },
        );
      },
    );
  }
}

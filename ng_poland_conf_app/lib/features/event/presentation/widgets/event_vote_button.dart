import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/authentication_page.dart';
import 'package:ng_poland_conf_app/features/event/presentation/cubit/event_vote_cubit.dart';
import 'package:ng_poland_conf_app/injectable.dart';
import 'package:ng_poland_conf_app/routing/routing.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    return FilledButton.tonalIcon(
      key: const Key('event-vote-like'),
      onPressed: enabled ? onTap : null,
      icon: Icon(
        liked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
        color: liked
            ? colorScheme.secondary
            : colorScheme.onSurface.withValues(alpha: 0.75),
      ),
      label: Text(liked ? 'Liked' : 'Like talk'),
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not save your vote')),
        );
      },
      builder: (context, state) {
        if (!state.showButton) {
          return const SizedBox.shrink();
        }

        final enabled = state.maybeWhen(
          saving: (_) => false,
          orElse: () => true,
        );

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: EventLikeButton(
            liked: state.liked,
            enabled: enabled,
            onTap: () {
              if (_cubit.requiresLogin()) {
                context.push(
                  AuthenticationPage.loginPath(
                    from: internalLocationFromUri(
                      GoRouterState.of(context).uri,
                    ),
                  ),
                );
                return;
              }
              _cubit.toggleLike();
            },
          ),
        );
      },
    );
  }
}

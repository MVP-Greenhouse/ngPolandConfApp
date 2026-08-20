import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/authentication_page.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/entities/speaker_vote_value.dart';
import 'package:ng_poland_conf_app/features/speakers/presentation/cubit/speaker_vote_cubit.dart';
import 'package:ng_poland_conf_app/injectable.dart';

class SpeakerVoteButtons extends StatelessWidget {
  const SpeakerVoteButtons({
    super.key,
    required this.current,
    required this.onTap,
    required this.enabled,
  });

  final SpeakerVoteValue? current;
  final ValueChanged<SpeakerVoteValue> onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            key: const Key('vote-up'),
            onPressed: enabled ? () => onTap(SpeakerVoteValue.up) : null,
            icon: Icon(
              Icons.thumb_up,
              color: current == SpeakerVoteValue.up
                  ? colorScheme.primary
                  : null,
            ),
          ),
          IconButton(
            key: const Key('vote-down'),
            onPressed: enabled ? () => onTap(SpeakerVoteValue.down) : null,
            icon: Icon(
              Icons.thumb_down,
              color: current == SpeakerVoteValue.down
                  ? colorScheme.primary
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

class SpeakerVoteButtonsHost extends StatefulWidget {
  const SpeakerVoteButtonsHost({
    super.key,
    required this.speakerId,
    this.enabled = true,
  });

  final String speakerId;
  final bool enabled;

  @override
  State<SpeakerVoteButtonsHost> createState() => _SpeakerVoteButtonsHostState();
}

class _SpeakerVoteButtonsHostState extends State<SpeakerVoteButtonsHost> {
  late final SpeakerVoteCubit _cubit;

  @override
  void initState() {
    _cubit = getIt.get<SpeakerVoteCubit>(param1: widget.speakerId);
    super.initState();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SpeakerVoteCubit, SpeakerVoteState>(
      bloc: _cubit,
      listenWhen: (previous, current) =>
          current.maybeWhen(failure: (_) => true, orElse: () => false),
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nie udało się zapisać głosu')),
        );
      },
      builder: (context, state) {
        if (!state.showButtons) {
          return const SizedBox.shrink();
        }

        final enabled =
            widget.enabled &&
            state.maybeWhen(saving: (_) => false, orElse: () => true);

        return SpeakerVoteButtons(
          current: state.vote,
          enabled: enabled,
          onTap: (value) {
            if (_cubit.requiresLogin()) {
              context.push(
                AuthenticationPage.loginPath(
                  from: GoRouterState.of(context).uri.toString(),
                ),
              );
              return;
            }
            _cubit.tap(value);
          },
        );
      },
    );
  }
}

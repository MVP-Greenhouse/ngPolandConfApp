import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ng_poland_conf_app/features/authentication/presentation/authentication_page.dart';
import 'package:ng_poland_conf_app/features/engagement/domains/logic/contest_home_view.dart';
import 'package:ng_poland_conf_app/features/home/datasources/data/contest_ui_local_datasource.dart';
import 'package:ng_poland_conf_app/features/home/presentation/cubit/contest_home_cubit.dart';
import 'package:ng_poland_conf_app/injectable.dart';

abstract final class ContestHomeCopy {
  static const join = 'Dołącz do konkursu';
  static const joined = 'Dołączono do konkursu';
  static const winTitle = 'Gratulacje!';
  static const winBody =
      'Wygrałeś nagrodę w konkursie. Odebrać możesz ją w strefie organizatorów.';
  static const loseBanner = 'Niestety nie udało się, może innym razem';
  static const joinFailure = 'Nie udało się dołączyć do konkursu';
}

class ContestHomeSection extends StatelessWidget {
  const ContestHomeSection({
    super.key,
    required this.view,
    required this.online,
    required this.onJoin,
  });

  final ContestHomeView view;
  final bool online;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) {
    return switch (view) {
      ContestHomeView.hidden => const SizedBox.shrink(),
      ContestHomeView.join => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: online ? onJoin : null,
            child: const Text(ContestHomeCopy.join),
          ),
        ),
      ),
      ContestHomeView.joined => const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: null,
            child: Text(ContestHomeCopy.joined),
          ),
        ),
      ),
      ContestHomeView.winner => const _ContestBanner(
        message: ContestHomeCopy.winBody,
        isWin: true,
      ),
      ContestHomeView.loser => const _ContestBanner(
        message: ContestHomeCopy.loseBanner,
        isWin: false,
      ),
    };
  }
}

class _ContestBanner extends StatelessWidget {
  const _ContestBanner({required this.message, required this.isWin});

  final String message;
  final bool isWin;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isWin
              ? colorScheme.primaryContainer.withValues(alpha: 0.85)
              : colorScheme.surfaceContainerHighest.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isWin ? colorScheme.primary : colorScheme.outline,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: colorScheme.onPrimaryContainer,
            ),
          ),
        ),
      ),
    );
  }
}

class ContestHomeSectionHost extends StatefulWidget {
  const ContestHomeSectionHost({super.key, required this.online});

  final bool online;

  @override
  State<ContestHomeSectionHost> createState() => _ContestHomeSectionHostState();
}

class _ContestHomeSectionHostState extends State<ContestHomeSectionHost> {
  late final ContestHomeCubit _cubit;
  late final ContestUiLocalDataSource _ui;

  @override
  void initState() {
    _cubit = getIt.get<ContestHomeCubit>();
    _ui = getIt.get<ContestUiLocalDataSource>();
    super.initState();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContestHomeCubit, ContestHomeState>(
      bloc: _cubit,
      listenWhen: (previous, current) =>
          !previous.joinFailed && current.joinFailed,
      listener: (context, state) {
        if (state.joinFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(ContestHomeCopy.joinFailure)),
          );
          _cubit.clearJoinFailed();
        }
      },
      builder: (context, state) {
        return ContestWinDialogListener(
          view: state.view,
          confId: state.latestConfId,
          ui: _ui,
          child: ContestHomeSection(
            view: state.view,
            online: widget.online,
            onJoin: () {
              if (_cubit.requiresLogin()) {
                context.push(
                  AuthenticationPage.loginPath(
                    from: GoRouterState.of(context).uri.toString(),
                  ),
                );
                return;
              }
              unawaited(_cubit.join());
            },
          ),
        );
      },
    );
  }
}

class ContestWinDialogListener extends StatefulWidget {
  const ContestWinDialogListener({
    super.key,
    required this.view,
    required this.confId,
    required this.ui,
    required this.child,
  });

  final ContestHomeView view;
  final String? confId;
  final ContestUiLocalDataSource ui;
  final Widget child;

  @override
  State<ContestWinDialogListener> createState() =>
      _ContestWinDialogListenerState();
}

class _ContestWinDialogListenerState extends State<ContestWinDialogListener> {
  String? _winDialogHandledConfId;

  @override
  Widget build(BuildContext context) {
    if (widget.view == ContestHomeView.winner) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        unawaited(_maybeShowWinDialog());
      });
    }
    return widget.child;
  }

  Future<void> _maybeShowWinDialog() async {
    final confId = widget.confId;
    if (confId == null) return;
    if (_winDialogHandledConfId == confId) return;
    _winDialogHandledConfId = confId;

    final shown = await widget.ui.wasWinDialogShown(confId);
    if (shown) return;
    if (!mounted) return;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text(ContestHomeCopy.winTitle),
        content: const Text(ContestHomeCopy.winBody),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
    await widget.ui.markWinDialogShown(confId);
  }
}

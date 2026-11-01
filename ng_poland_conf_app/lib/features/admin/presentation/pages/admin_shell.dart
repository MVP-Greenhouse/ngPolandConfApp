import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/app_notice.dart';
import 'package:ng_poland_conf_app/features/admin/presentation/cubit/admin_cubit.dart';

/// Shows admin action feedback. Expects an [AdminCubit] above it.
class AdminShell extends StatelessWidget {
  const AdminShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminCubit, AdminState>(
      listenWhen: (previous, current) =>
          current.notice != null && previous.notice != current.notice,
      listener: (context, state) {
        if (state.notice case final notice?) {
          showAppNotice(context, notice);
          context.read<AdminCubit>().clearNotice();
        }
      },
      child: child,
    );
  }
}

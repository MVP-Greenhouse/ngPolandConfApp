import 'package:flutter/widgets.dart';

/// Provides app-shell pieces (the navigation drawer) to [CustomScaffold]
/// without making shared widgets depend on features.
class AppShellScope extends InheritedWidget {
  const AppShellScope({
    super.key,
    required this.drawerBuilder,
    required super.child,
  });

  final WidgetBuilder drawerBuilder;

  static WidgetBuilder? drawerBuilderOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<AppShellScope>()
      ?.drawerBuilder;

  @override
  bool updateShouldNotify(AppShellScope oldWidget) =>
      drawerBuilder != oldWidget.drawerBuilder;
}

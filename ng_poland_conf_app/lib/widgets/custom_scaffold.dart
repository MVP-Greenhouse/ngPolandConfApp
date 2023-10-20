import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/widgets/custom_drawer.dart';

class CustomScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final bool showDrawer;
  final bool showBottomNavigationBar;
  final Widget bottomNavigationBar;

  const CustomScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.showDrawer = true,
    this.showBottomNavigationBar = false,
    this.bottomNavigationBar = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar ?? AppBar(),
      drawer: showDrawer ? const CustomDrawer() : null,
      body: body,
      bottomNavigationBar: showBottomNavigationBar ? bottomNavigationBar : null,
    );
  }
}

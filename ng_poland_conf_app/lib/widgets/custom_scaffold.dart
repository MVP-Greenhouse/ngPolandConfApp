import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/widgets/custom_drawer.dart';

class CustomScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final bool showDrawer;

  const CustomScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.showDrawer = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar ?? AppBar(),
      drawer: showDrawer ? const CustomDrawer() : null,
      body: body,
    );
  }
}

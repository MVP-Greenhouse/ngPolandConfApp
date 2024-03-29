import 'package:flutter/material.dart';
import 'package:ngPolandConf/providers/workShops.dart';
import 'package:ngPolandConf/shared/widgets/animatedBottomNav.dart';
import 'package:ngPolandConf/widgets/connection.dart';
import 'package:ngPolandConf/widgets/drawer.dart';
import 'package:ngPolandConf/widgets/workshops/content.dart';
import 'package:provider/provider.dart';

class Workshops extends StatefulWidget {
  const Workshops({Key key, this.title}) : super(key: key);

  static const routeName = '/Workshops';
  final String title;

  @override
  _WorkshopsState createState() => _WorkshopsState();
}

class _WorkshopsState extends State<Workshops> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [ConnectionStatus()],
      ),
      drawer: const DrawerNg(
        pageName: Workshops.routeName,
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () => Provider.of<WorkshopsProvider>(context, listen: false)
            .fetchData(howMany: 999, reload: true),
        child: WorkshopsContent(),
      ),
      bottomNavigationBar: AnimatedBottomNav(
        deviceSize: MediaQuery.of(context).size,
        provider: WorkshopsProvider,
        refreshIndicatorKey: _refreshIndicatorKey,
      ),
    );
  }
}

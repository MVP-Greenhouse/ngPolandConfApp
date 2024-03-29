import 'package:flutter/material.dart';
import 'package:ngPolandConf/models/contentful.dart';
import 'package:ngPolandConf/providers/eventItems.dart';
import 'package:ngPolandConf/providers/themeManager.dart';
import 'package:ngPolandConf/providers/workShops.dart';
import 'package:ngPolandConf/services/contentful.dart';
import 'package:provider/provider.dart';

class AnimatedBottomNav extends StatefulWidget {
  const AnimatedBottomNav({
    this.deviceSize,
    this.provider,
    this.refreshIndicatorKey,
  });

  final Size deviceSize;
  final dynamic provider;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

  @override
  _AnimatedBottomNavState createState() => _AnimatedBottomNavState();
}

class _AnimatedBottomNavState extends State<AnimatedBottomNav> {
  double _positionAnimatedColor;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EventItemType _selectedItems;

    if (widget.provider == EventItemsProvider) {
      _selectedItems = Provider.of<EventItemsProvider>(context).selectedItems;
    } else {
      _selectedItems = Provider.of<WorkshopsProvider>(context).selectedItems;
    }

    bool _darkMode = Provider.of<ThemeNotifier>(context).darkTheme;

    if (_selectedItems == EventItemType.NGPOLAND) {
      _positionAnimatedColor = 0.0;
    } else {
      _positionAnimatedColor = 0.5;
    }

    return Container(
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.height * 0.09
          : MediaQuery.of(context).size.width * 0.09,
      decoration: const BoxDecoration(color: Colors.black),
      child: Container(
        decoration: _darkMode
            ? const BoxDecoration(
                color: Colors.white24,
              )
            : const BoxDecoration(
                color: Colors.white,
              ),
        child: Stack(
          fit: StackFit.loose,
          alignment: Alignment.bottomCenter,
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeIn,
              left: widget.deviceSize.width * _positionAnimatedColor,
              child: Container(
                width: widget.deviceSize.width * 0.5,
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? widget.deviceSize.width * 0.01
                        : widget.deviceSize.height * 0.01,
                child: Container(
                  width: double.infinity,
                  height: widget.deviceSize.width * 0.01,
                  child: const Card(
                    margin: EdgeInsets.all(0),
                    color: Color.fromRGBO(255, 0, 122, 1),
                  ),
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (widget.provider == EventItemsProvider) {
                          Provider.of<EventItemsProvider>(context,
                                  listen: false)
                              .selectedItems = EventItemType.NGPOLAND;

                          List<EventItem> _eventItems =
                              Provider.of<EventItemsProvider>(context,
                                      listen: false)
                                  .eventItems;

                          if (_eventItems == null || _eventItems.isEmpty) {
                            widget.refreshIndicatorKey.currentState?.show();
                          }
                        } else {
                          Provider.of<WorkshopsProvider>(context, listen: false)
                              .selectedItems = EventItemType.NGPOLAND;

                          List<Workshop> _workshopItems =
                              Provider.of<WorkshopsProvider>(context,
                                      listen: false)
                                  .workshopItems;

                          if (_workshopItems == null ||
                              _workshopItems.isEmpty) {
                            widget.refreshIndicatorKey.currentState?.show();
                          }
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: FittedBox(
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Image.asset(
                              'assets/images/ngpolandlogo.png',
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? MediaQuery.of(context).size.height * 0.075
                                  : MediaQuery.of(context).size.width * 0.075,
                            ),
                            Text(
                              'NG POLAND',
                              textScaleFactor: 7,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                    color: _darkMode
                                        ? _selectedItems ==
                                                EventItemType.NGPOLAND
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                            : Colors.white
                                        : _selectedItems ==
                                                EventItemType.NGPOLAND
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                            : Colors.black,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (widget.provider == EventItemsProvider) {
                          Provider.of<EventItemsProvider>(context,
                                  listen: false)
                              .selectedItems = EventItemType.JSPOLAND;

                          List<EventItem> _eventItems =
                              Provider.of<EventItemsProvider>(context,
                                      listen: false)
                                  .eventItems;

                          if (_eventItems == null || _eventItems.isEmpty) {
                            widget.refreshIndicatorKey.currentState?.show();
                          }
                        } else {
                          Provider.of<WorkshopsProvider>(context, listen: false)
                              .selectedItems = EventItemType.JSPOLAND;

                          List<Workshop> _workshopItems =
                              Provider.of<WorkshopsProvider>(context,
                                      listen: false)
                                  .workshopItems;

                          if (_workshopItems == null ||
                              _workshopItems.isEmpty) {
                            widget.refreshIndicatorKey.currentState?.show();
                          }
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Image.asset(
                              'assets/images/jspolandlogo.png',
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? MediaQuery.of(context).size.height * 0.09
                                  : MediaQuery.of(context).size.width * 0.09,
                            ),
                            Text(
                              'JS POLAND',
                              textScaleFactor: 7,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                    color: _darkMode
                                        ? _selectedItems ==
                                                EventItemType.JSPOLAND
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                            : Colors.white
                                        : _selectedItems ==
                                                EventItemType.JSPOLAND
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                            : Colors.black,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

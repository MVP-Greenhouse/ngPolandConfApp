import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../settings/presentation/connection_status.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  late final WebViewController controller;
  ConnectivityResult connectivityResult = ConnectivityResult.none;
  late StreamSubscription<ConnectivityResult> subscription;

  var loadingPercentage = 0;
  @override
  void initState() {
    super.initState();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        connectivityResult = result;
      });
    });
    if (webViewPlatform()) {
      controller = WebViewController()
        ..setNavigationDelegate(NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress - 1;
            });
          },
          onPageFinished: (url) {
            Future.delayed(const Duration(milliseconds: 300), () {
              setState(() {
                loadingPercentage = 100;
              });
            });
          },
        ))
        ..loadRequest(
          Uri.parse('https://ngask.dev/'),
        );
    }
  }

  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }

  bool webViewPlatform() {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.open_in_new_rounded,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            onPressed: () {
              launchUrl(Uri.parse('https://ngask.dev/'));
            },
          ),
          const ConnectionStatus(),
        ],
        title: Text(
          'Q&A',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.inversePrimary),
        ),
      ),
      body: loadingPercentage < 100 && webViewPlatform()
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.tertiaryContainer,
              ),
            )
          : !webViewPlatform()
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 24.0,
                            ),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        icon: Icon(
                          Icons.open_in_new_rounded,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        label: Text(
                          'Open the Q&A form in a new tab',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        onPressed: () {
                          launchUrl(Uri.parse('https://ngask.dev/'));
                        },
                      ),
                    ],
                  ),
                )
              : WebViewWidget(
                  controller: controller,
                ),
    );
  }
}

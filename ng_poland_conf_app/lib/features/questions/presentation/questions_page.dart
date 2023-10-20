import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/widgets/custom_scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  late final WebViewController controller;
  var loadingPercentage = 0;
  @override
  void initState() {
    super.initState();
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
          Future.delayed(const Duration(milliseconds: 500), () {
            setState(() {
              loadingPercentage = 100;
            });
          });
        },
      ))
      ..loadRequest(
        Uri.parse('https://myconf.dev/'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text(
          'Q&A',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.inversePrimary),
        ),
      ),
      body: loadingPercentage < 100
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.tertiaryContainer,
              ),
            )
          : WebViewWidget(
              controller: controller,
            ),

      // Stack(
      //   children: [
      //     WebViewWidget(
      //       controller: controller,
      //     ),
      //     if (loadingPercentage < 100)
      //       LinearProgressIndicator(
      //         backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
      //         minHeight: 6,
      //         value: loadingPercentage / 100.0,
      //       ),
      //   ],
      // ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ng_poland_conf_app/core/presentation/theme/app_palette.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/connection_status.dart';
import 'package:ng_poland_conf_app/core/presentation/widgets/custom_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Audience Q&A hosted on ngask.dev: embedded on mobile, a link elsewhere.
class QuestionsPage extends StatelessWidget {
  const QuestionsPage({super.key});

  static final qaUrl = Uri.parse('https://ngask.dev/');

  static bool get _supportsWebView =>
      !kIsWeb &&
      (defaultTargetPlatform == .android || defaultTargetPlatform == .iOS);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.open_in_new_rounded,
              color: theme.colorScheme.inversePrimary,
            ),
            onPressed: () => launchUrl(qaUrl),
          ),
          const ConnectionStatus(),
        ],
        title: Text(
          'Q&A',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.inversePrimary,
          ),
        ),
      ),
      body: _supportsWebView
          ? const _QuestionsWebView()
          : const _OpenInBrowser(),
    );
  }
}

class _QuestionsWebView extends HookWidget {
  const _QuestionsWebView();

  /// Keeps the spinner a moment longer so the page does not flash in.
  static const _revealDelay = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    final loaded = useState(false);
    final controller = useMemoized(
      () => WebViewController()
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (_) => loaded.value = false,
            onPageFinished: (_) => Future.delayed(_revealDelay, () {
              if (context.mounted) loaded.value = true;
            }),
          ),
        )
        ..loadRequest(QuestionsPage.qaUrl),
    );

    if (loaded.value) return WebViewWidget(controller: controller);
    return ColoredBox(
      color: context.palette.screen,
      child: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.tertiaryContainer,
        ),
      ),
    );
  }
}

class _OpenInBrowser extends StatelessWidget {
  const _OpenInBrowser();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: TextButton.icon(
        style: TextButton.styleFrom(
          padding: const .symmetric(horizontal: 16, vertical: 24),
          shape: RoundedRectangleBorder(borderRadius: .circular(8)),
        ),
        icon: Icon(
          Icons.open_in_new_rounded,
          color: theme.colorScheme.onPrimary,
        ),
        label: Text(
          'Open the Q&A form in a new tab',
          style: theme.textTheme.bodySmall,
        ),
        onPressed: () => launchUrl(QuestionsPage.qaUrl),
      ),
    );
  }
}

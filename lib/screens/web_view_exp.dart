import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zendy/widgets/widgets.dart';

class WebViewExp extends StatefulWidget {
  final String url;
  final bool showAppbar; // New parameter for controlling the app bar visibility

  const WebViewExp({required this.url, this.showAppbar = false, Key? key})
      : super(key: key);

  @override
  State<WebViewExp> createState() => _WebViewExpState();
}

class _WebViewExpState extends State<WebViewExp> {
  late final WebViewController controller;
  bool isLoading = true;
  int _progress = 0;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) => setState(() => isLoading = true),
          onPageFinished: (String url) => setState(() => isLoading = false),
          onProgress: (progress) => setState(() => _progress = progress),
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(widget.url)); // Use the widget.url here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showAppbar ? _buildAppBar() : null,
      body: Stack(
        children: [
          if (!isLoading) WebViewWidget(controller: controller),
          if (isLoading) _buildProgressIndicator(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.scale(
            scale: 1.5,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Theme.of(Get.context!).primaryColor,
            ),
          ),
          TextBody('$_progress %'),
        ],
      ),
    );
  }
}

PreferredSizeWidget _buildAppBar() {
  return AppBar(
    iconTheme: IconThemeData(color: Theme.of(Get.context!).primaryColor),
    backgroundColor: Theme.of(Get.context!).colorScheme.background,
    leading: const BackBtn(),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 4),
        child: IconButton(
          splashRadius: 24,
          icon: const Icon(FontIcons.share),
          onPressed: () {},
        ),
      )
    ],
  );
}

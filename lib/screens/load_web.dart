import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:zendy_app/controllers/controllers.dart';

class LoadWebScreen extends StatelessWidget {
  final AuthController authCtrl = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    WebView.platform = SurfaceAndroidWebView();
    var url = Get.arguments;
    print('> url >' + url);

    Widget bodyContent = Center(child: Text('Hmmm..., some thing went wrong'));

    var _headers = {"Cookie": authCtrl.currentUser.value.authToken};

    if (RegExp(r'.+\.pdf$').hasMatch(url)) {
      bodyContent = const PDF().cachedFromUrl(
        url,
        headers: _headers,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      );
    } else {
      bodyContent = WebView(
        onWebViewCreated: (controller) {
          controller.loadUrl(
            url,
            headers: _headers,
          );
        },
      );
    }

    return Scaffold(
      appBar: _buildAppBar(),
      body: bodyContent,
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: _buildBackButton(),
      actions: [
        IconButton(
          splashRadius: 24,
          icon: Icon(Icons.save_alt_rounded),
          onPressed: () {},
        ),
        Padding(
          padding: EdgeInsets.only(right: 4),
          child: IconButton(
            splashRadius: 24,
            icon: Icon(Icons.ios_share),
            onPressed: () {},
          ),
        )
      ],
    );
  }

  Widget _buildBackButton() {
    return IconButton(
      splashRadius: 24,
      icon: Icon(Icons.arrow_back_rounded),
      onPressed: () => Get.back(),
    );
  }
}

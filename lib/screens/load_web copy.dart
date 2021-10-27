import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:zendy_app/controllers/controllers.dart';
import 'package:zendy_app/controllers/request_controller.dart';

void getHttp(url) async {
  final requestCtrl = RequestController();
  final _request = requestCtrl.request();

  try {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = appDocDir.path;

    dynamic response1 = await _request.get(url, '$path/pdf/xx.html');
    dynamic response = await _request.download(url, '$path/pdf/xx.html');

    print('---->>>>');
    print(response1);
    print(response);
    print('---->>>');
  } catch (e) {
    print(e);
  }
}

class LoadWebScreen extends StatelessWidget {
  final AuthController authCtrl = Get.put(AuthController());
  final requestCtrl = RequestController();

  @override
  Widget build(BuildContext context) {
    WebView.platform = SurfaceAndroidWebView();
    var url = Get.arguments;
    print('> url >' + url);

    Widget bodyContent = Center(child: Text('Hmmm..., some thing went wrong'));

    var _headers = {"Cookie": authCtrl.currentUser.value.authToken};

    if (!url.isEmpty) {
      getHttp(url);
    }

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

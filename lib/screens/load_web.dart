import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:zendy_app/controllers/controllers.dart';
import 'package:zendy_app/widgets/widgets.dart';
import 'package:zendy_app/controllers/request_controller.dart';

void getHttp(url) async {
  final requestCtrl = RequestController();
  final _request = requestCtrl.request();

  try {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    String path = await getDirectoryPath();

    dynamic response = await _request.download(url, '$path/pdf/xx.html');

    print('---->>>>');
    print(response);
    print('---->>>');
  } catch (e) {
    print(e);
  }
}

Future<String> getDirectoryPath() async {
  Directory appDocDirectory = await getApplicationDocumentsDirectory();

  Directory directory = await new Directory(
    appDocDirectory.path + '/' + 'dir',
  ).create(recursive: true);

  return directory.path;
}

class LoadWebScreen extends StatelessWidget {
  final AuthController authCtrl = Get.put(AuthController());
  final requestCtrl = RequestController();

  @override
  Widget build(BuildContext context) {
    WebView.platform = SurfaceAndroidWebView();
    Map url = Get.arguments;
    String _readLink = url['read'];
    String _downloadLink = url['download'];
    print('> url >' + url.toString());

    Widget bodyContent =
        Center(child: TextBody('Hmmm..., some thing went wrong'));

    var _headers = {"Cookie": authCtrl.currentUser.value.authToken};

    if (!authCtrl.isLoggedIn()) {
      loginToProceed();
      return Scaffold(
        appBar: _buildAppBar(),
        body: TextBody('User Not loggedIn'),
      );
    }

    // if (!url.isEmpty) {
    //   getHttp(url);
    // }

    // if (RegExp(r'.+\.pdf$').hasMatch(url)) {
    if (_downloadLink.isNotEmpty) {
      bodyContent = const PDF().cachedFromUrl(
        _downloadLink,
        headers: _headers,
        placeholder: (double progress) => Center(
          child: TextBody('$progress %'),
        ),
        errorWidget: (dynamic error) => _buildPdfError(error),
      );
    } else if (_readLink.isNotEmpty) {
      bodyContent = WebView(
        // onWebResourceError: (dynamic error) => _buildPdfError(error),
        onWebViewCreated: (controller) {
          controller.loadUrl(
            _readLink,
            headers: _headers,
          );
        },
      );
      print('object');
    } else {
      bodyContent = Center(child: TextBody('Hmmm..., No link'));
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

  dynamic _buildPdfError(dynamic error) {
    print('object--------?');
    if (error.statusCode == 401) {
      loginToProceed();
    }
    return Center(child: TextBody(error.toString()));
  }
}

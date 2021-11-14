import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:zendy_app/controllers/controllers.dart';
import 'package:zendy_app/widgets/widgets.dart';
import 'package:zendy_app/controllers/request_controller.dart';

const _pdfInst = PDF(
  pageSnap: false,
  autoSpacing: false,
  pageFling: false,
);

void getHttp(url) async {
  final _request = RequestController().requestWithAuth();

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
  // final LibraryController libraryController = Get.find();

  @override
  Widget build(BuildContext context) {
    WebView.platform = SurfaceAndroidWebView();
    Map url = Get.arguments;

    // bool _inLibrary = true;

    // if (_inLibrary) {
    //   var _libraryData = libraryController.getData();
    //   print(_libraryData);
    // }

    String _readLink = url['read'];
    String _downloadLink = url['download'];
    print('> url >' + url.toString());

    Widget bodyContent = Center(
      child: TextBody('Hmmm..., some thing went wrong'),
    );

    var _headers = {"Cookie": authCtrl.currentUser.value.authToken};

    if (!authCtrl.isLoggedIn()) {
      loginToProceed();
      return Scaffold(
        appBar: _buildAppBar(),
        body: TextBody('User Not loggedIn'),
      );
    }

    if (_downloadLink.isNotEmpty) {
      bodyContent = _pdfInst.cachedFromUrl(
        _downloadLink,
        headers: _headers,
        placeholder: (progress) => _buildProgressIndicator(progress),
        errorWidget: (dynamic error) => _buildPdfError(error),
      );
    } else if (_readLink.isNotEmpty) {
      bodyContent = WebView(
        onWebViewCreated: (controller) {
          controller.loadUrl(
            _readLink,
            headers: _headers,
          );
        },
        onProgress: (progress) => _buildProgressIndicator(progress),
      );
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
      iconTheme: IconThemeData(color: Theme.of(Get.context).primaryColor),
      backgroundColor: Theme.of(Get.context).backgroundColor,
      leading: BackBtn(),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 4),
          child: IconButton(
            splashRadius: 24,
            icon: Icon(FontIcons.share),
            onPressed: () {},
          ),
        )
      ],
    );
  }

  Widget _buildProgressIndicator(progress) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.scale(
            scale: 1.5,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Theme.of(Get.context).primaryColor,
            ),
          ),
          TextBody('$progress %'),
        ],
      ),
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

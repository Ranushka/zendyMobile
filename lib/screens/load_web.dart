import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:pdf_viewer_jk/pdf_viewer_jk.dart';

import 'package:zendy_app/services/services.dart';
import 'package:zendy_app/controllers/controllers.dart';

Widget _buildPdfView(url, _headers) {
  return FutureBuilder(
    future: PDFDocument.fromURL(url, headers: _headers),
    builder: (_, pdfData) {
      if (pdfData.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (pdfData.data == null) {
        return Text('No PDF data');
      } else {
        return PDFViewer(
          document: pdfData.data,
          scrollDirection: Axis.vertical,
          showPicker: false,
          lazyLoad: false,
          navigationBuilder: (
            context,
            page,
            totalPages,
            jumpToPage,
            animateToPage,
          ) {
            return ButtonBar(children: []);
          },
        );
      }
    },
  );
}

class LoadWebScreen extends StatelessWidget {
  final AuthController authCtrl = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    WebView.platform = SurfaceAndroidWebView();
    var url = Get.arguments;
    // url = url.replaceAll("http://", "https://");

    Widget bodyContent = Center(child: Text('Hmmm..., some thing went wrong'));

    var _headers = {"Cookie": authCtrl.currentUser.value.authToken};
    print('>>>>url>>>>' + url);

    // if (url != '') {
    //   bodyContent = WebView(
    //     onWebViewCreated: (controller) {
    //       controller.loadUrl(
    //         url,
    //         headers: _headers,
    //       );
    //     },
    //   );
    // }

    // if (RegExp(r'.+\.pdf$').hasMatch(url)) {
    // if (RegExp(r'.+\pdf$').hasMatch(url)) {
    bodyContent = _buildPdfView(url, _headers);
    // }

    return Scaffold(
      appBar: _buildAppBar(),
      body: bodyContent,
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      brightness: Brightness.light,
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

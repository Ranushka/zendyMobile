import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:pdf_viewer_jk/pdf_viewer_jk.dart';

Widget _buildPdfView(url) {
  return FutureBuilder(
    future: PDFDocument.fromURL(url),
    builder: (_, pdfData) {
      print(pdfData);
      if (pdfData.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (pdfData.data == null) {
        return Text('No PDF data');
      } else {
        return PDFViewer(
          document: pdfData.data,
          scrollDirection: Axis.vertical,
          showPicker: false,
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
  @override
  Widget build(BuildContext context) {
    print(Get.arguments);
    var url = Get.arguments;
    url = url.replaceAll("http://", "https://");

    Widget bodyContent = Center(child: Text('Hmmm..., some thing went wrong'));

    if (url != '') {
      bodyContent = WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      );
    }

    if (RegExp(r'.+\.pdf$').hasMatch(url)) {
      bodyContent = _buildPdfView(url);
    }

    return Scaffold(
      appBar: _buildAppBar(),
      body: bodyContent,
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: Colors.blue),
      leading: _buildBackButton(),
      actions: [
        IconButton(
          splashRadius: 24,
          icon: Icon(Icons.save_alt_rounded),
          onPressed: () {},
        ),
        IconButton(
          splashRadius: 24,
          icon: Icon(Icons.ios_share),
          onPressed: () {},
        )
      ],
    );
  }

  Widget _buildBackButton() {
    return IconButton(
      splashRadius: 28,
      padding: EdgeInsets.fromLTRB(16, 4, 24, 8),
      icon: Icon(Icons.arrow_back_rounded),
      onPressed: () => Get.back(),
    );
  }
}

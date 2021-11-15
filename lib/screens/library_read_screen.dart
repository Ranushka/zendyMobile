import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import 'package:zendy_app/controllers/controllers.dart';
import 'package:zendy_app/widgets/widgets.dart';

final _pdfInst = PDF(
  pageSnap: false,
  autoSpacing: false,
  pageFling: false,
);

class LibraryReadScreen extends StatefulWidget {
  @override
  _LibraryReadScreenState createState() => _LibraryReadScreenState();
}

class _LibraryReadScreenState extends State<LibraryReadScreen> {
  final LibraryController libraryController = Get.find();
  final AuthController authController = Get.find();
  var readItemIndex = Get.arguments;

  int initPosition = Get.arguments ?? 0;

  @override
  Widget build(BuildContext context) {
    var _headers = {"Cookie": authController.currentUser.value.authToken};

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: StreamBuilder(
          stream: libraryController.getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data.toString() == 'null') {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: TextBody('Something went wrong'));
            }

            if (snapshot.data.docs.length < 1) {
              return Gutter(Center(
                child: TextBody(
                  'Add Search results to your library will help you to read or export later',
                ),
              ));
            }

            return CustomTabView(
              initPosition: initPosition,
              itemCount: snapshot.data.size,
              tabBuilder: (context, index) {
                return SizedBox(
                  width: 0,
                  child: Tab(
                    icon: Icon(
                      Icons.description_rounded,
                      size: 12,
                    ),
                  ),
                );
              },
              pageBuilder: (context, index) {
                final item = snapshot.data.docs[index];
                String _downloadLink = item['downloadLink'];

                return Tab(
                  child: _pdfInst.cachedFromUrl(
                    _downloadLink,
                    headers: _headers,
                    placeholder: (progress) =>
                        _buildProgressIndicator(progress),
                    errorWidget: (dynamic error) => _buildPdfError(error),
                  ),
                );
              },
              onPositionChange: (index) {
                // print('current position: $index');
                initPosition = index;
              },
              onScroll: (position) {
                // print('$position');
              },
            );
          },
        ),
      ),
    );
  }
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

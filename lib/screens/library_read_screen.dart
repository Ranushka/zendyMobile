import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import 'package:zendy/controllers/controllers.dart';
import 'package:zendy/helpers/print_log.dart';
import 'package:zendy/screens/web_view_exp.dart';
import 'package:zendy/widgets/widgets.dart';
import 'package:zendy/helpers/helpers.dart';

const _pdfInst = PDF(
  pageSnap: false,
  autoSpacing: false,
  pageFling: false,
);

class LibraryReadScreen extends StatefulWidget {
  const LibraryReadScreen({super.key});

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
    var headers0 = {"Cookie": authController.currentUser.value.authToken};

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: StreamBuilder(
          stream: libraryController.getData(),
          builder: (BuildContext context, snapshot) {
            //  final data0 = searchResults?['searchResults']?['results']![index];

            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            }

            print('-----------====');
            print(snapshot);
            print('-----------====');

            if (snapshot.hasError) {
              return const Center(child: TextBody('Something went wrong'));
            }

            // if (snapshot.data.length < 1) {
            //   return const Gutter(Center(
            //     child: TextBody(
            //       'Add Search results to your library will help you to read or export later',
            //     ),
            //   ));
            // }

            return CustomTabView(
              initPosition: initPosition,
              itemCount: snapshot.data.length,
              tabBuilder: (context, index) {
                return const SizedBox(
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
                var providedDataString = snapshot.data[index];
                Map<String, dynamic> _item = json.decode(
                  providedDataString['data'],
                );

                printLog('CustomTabView readLink', _item['readLink']);
                // printLog('CustomTabView downloadLink', _item['downloadLink']);

                Map<String, String> headers = headers0.map(
                  (key, value) => MapEntry(key, value.toString()),
                );

                return Tab(
                  child: _item['readLink'] == null
                      ? _pdfInst.cachedFromUrl(
                          _item['downloadLink'],
                          headers: headers,
                          placeholder: (progress) =>
                              _buildProgressIndicator(progress),
                          errorWidget: (dynamic error) => _buildPdfError(error),
                        )
                      : WebViewExp(url: _item['readLink']),
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
            color: Theme.of(Get.context!).primaryColor,
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

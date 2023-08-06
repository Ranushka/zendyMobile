import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import 'package:zendy/controllers/controllers.dart';
import 'package:zendy/helpers/print_log.dart';
import 'package:zendy/screens/web_view_exp.dart';
import 'package:zendy/widgets/widgets.dart';

Future<String> getDirectoryPath() async {
  Directory appDocDirectory = await getApplicationDocumentsDirectory();

  Directory directory = await Directory(
    '${appDocDirectory.path}/dir',
  ).create(recursive: true);

  return directory.path;
}

class LoadWebScreen extends StatelessWidget {
  final AuthController authCtrl = Get.put(AuthController());

  LoadWebScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map url = Get.arguments;

    String readLink = url['read'] ?? '';
    String downloadLink = url['download'] ?? '';
    print('> url >$url');

    Widget bodyContent = const Center(
      child: TextBody('Hmmm..., some thing went wrong'),
    );

    // var headers = {"Cookie": authCtrl.currentUser.value.authToken};
    // final headersCast = headers.cast<String, String>();
    // printLog('headersCast', headersCast);

    if (!authCtrl.isLoggedIn()) {
      loginToProceed();
      return Scaffold(
        appBar: _buildAppBar(),
        body: const TextBody('User Not loggedIn'),
      );
    }

    if (downloadLink.isNotEmpty) {
      printLog('downloadLink--', downloadLink);
      bodyContent = PDF().cachedFromUrl(
        downloadLink,
        placeholder: (progress) => Center(child: Text('$progress %')),
        errorWidget: (error) => Center(child: Text(error.toString())),
      );
    } else if (readLink.isNotEmpty) {
      bodyContent = WebViewExp(url: readLink);
    } else {
      bodyContent = const Center(child: TextBody('Hmmm..., No link'));
    }

    return Scaffold(
      appBar: _buildAppBar(),
      body: bodyContent,
    );
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
}

// import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy_app/controllers/detail_controller.dart';
import 'package:zendy_app/widgets/typography.dart';

class DetailScreen extends StatelessWidget {
  final DetailController detailController = Get.put(DetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar() as PreferredSizeWidget,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: _buildHeadActions(),
              floating: true,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.blue),
              // pinned: true,
              snap: true,
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(() {
            if (detailController.isLoading.value)
              return Center(child: CircularProgressIndicator());
            else
              return _buildMainContent(detailController.detailData.value);
          }),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      brightness: Brightness.light,
      automaticallyImplyLeading: false,
      toolbarHeight: 0,
      elevation: 0,
    );
  }

  Widget _buildHeadActions() {
    return SingleChildScrollView(
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.ios_share),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(dynamic data) {
    final bib = data.bibjson;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          if (bib?.title != null) Title2(bib.title),
          SizedBox(height: 8),
          if (bib?.bibjsonAbstract != null) TextBody(bib.bibjsonAbstract),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}

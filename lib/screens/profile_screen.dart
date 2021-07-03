import 'package:flutter/material.dart';
// import 'package:get/get.dart';

import 'package:zendy_app/widgets/widgets.dart';
// import 'package:zendy_app/helpers/helpers.dart';
// import 'package:zendy_app/controllers/product_controller.dart';

class ProfileScreen extends StatelessWidget {
  // final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();

    return Scaffold(
      appBar: emptyAppbar(),
      body: Column(
        children: [
          Expanded(
            child: _buildMainContent(),
            // child: Obx(() {
            //   if (productController.isLoading.value)
            //     return Center(child: CircularProgressIndicator());
            //   else
            //     return _buildMainContent();
            // }),
          ),
        ],
      ),
      bottomNavigationBar: bottomNavigation(),
    );
  }

  Widget _buildMainContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 32),
          Title1('Profile'),
          SizedBox(height: 16),
        ],
        direction: Axis.vertical,
      ),
    );
  }
}

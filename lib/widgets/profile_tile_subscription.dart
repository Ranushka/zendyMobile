import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy_app/widgets/widgets.dart';

Widget buildUserSubscrionInfo() {
  final _isExpanded = false.obs;
  final _getIcon = (active) {
    if (active) return Icon(Icons.keyboard_arrow_up);
    return Icon(Icons.keyboard_arrow_down);
  };

  return Container(
    child: Obx(
      () {
        return Column(
          children: [
            InkWell(
              onTap: () {
                _isExpanded(!_isExpanded.value);
              },
              child: Container(
                // padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                padding: EdgeInsets.all(16),
                color: Theme.of(Get.context).backgroundColor,
                child: Flex(
                  direction: Axis.horizontal,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.payment_outlined,
                      color: Colors.grey.shade500,
                    ),
                    SizedBox(width: 16),
                    Title3('Your Subscription is'),
                    SizedBox(width: 16),
                    TextSmall('Active'),
                    Spacer(),
                    _getIcon(_isExpanded.value)
                  ],
                ),
              ),
            ),
            if (_isExpanded.value)
              Container(
                color: Theme.of(Get.context).backgroundColor,
                child: Column(
                  children: [
                    dividerX,
                    // SizedBox(height: 8),
                    ProfileTilePlan(),
                    dividerX,
                    ProfileTilePayment(),
                    dividerX,
                    ProfileTilePaymentHistory(),
                    SizedBox(height: 16),
                  ],
                ),
              )
          ],
        );
      },
    ),
  );
}

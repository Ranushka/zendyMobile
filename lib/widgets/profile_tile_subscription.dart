import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy_app/helpers/helpers.dart';
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
                color: Colors.white,
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
                    SmallMute('Active'),
                    Spacer(),
                    _getIcon(_isExpanded.value)
                  ],
                ),
              ),
            ),
            if (_isExpanded.value)
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    DividerX,
                    SizedBox(height: 16),
                    ProfileTilePlan(),
                    DividerX,
                    ProfileTilePayment(),
                    DividerX,
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

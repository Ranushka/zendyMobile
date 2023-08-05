import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy/widgets/widgets.dart';

Widget buildUserSubscrionInfo() {
  final isExpanded = false.obs;
  getIcon(active) {
    if (active) return const Icon(Icons.keyboard_arrow_up);
    return const Icon(Icons.keyboard_arrow_down);
  }

  return Container(
    child: Obx(
      () {
        return Column(
          children: [
            InkWell(
              onTap: () {
                isExpanded(!isExpanded.value);
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Theme.of(Get.context!).colorScheme.background,
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Icon(
                      Icons.payment_outlined,
                      color: Colors.grey.shade500,
                    ),
                    const SizedBox(width: 16),
                    const Title3('Your Subscription is'),
                    const SizedBox(width: 16),
                    const TextSmall('Active'),
                    const Spacer(),
                    getIcon(isExpanded.value)
                  ],
                ),
              ),
            ),
            if (isExpanded.value)
              Container(
                color: Theme.of(Get.context!).colorScheme.background,
                child: Column(
                  children: [
                    dividerX,
                    const ProfileTilePlan(),
                    dividerX,
                    const ProfileTilePayment(),
                    dividerX,
                    const ProfileTilePaymentHistory(),
                    const SizedBox(height: 16),
                  ],
                ),
              )
          ],
        );
      },
    ),
  );
}

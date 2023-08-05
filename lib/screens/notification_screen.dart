import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zendy/helpers/helpers.dart';
import 'package:zendy/widgets/app_bar_logo.dart';
import 'package:zendy/widgets/widgets.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Column(
          children: [
            const SizedBox(height: 50),
            AppBarLogo(showBackBtn: true),
          ],
        ),
        // ,
      ),
      body: Column(
        children: [
          const SizedBox(height: 32),
          Title1('Notifications'),
          const SizedBox(height: 32),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (true) {
      if (true) {
        return Center(
          child: Text('No new notifications'),
        );
      } else {
        return _buildNotificationList([]);
      }
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'You will be able to track latest developments in your field.'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Get.toNamed(Goto.login),
              child: Text('Login'),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildNotificationList(List<String> notifications) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(notifications[index]),
        );
      },
    );
  }
}

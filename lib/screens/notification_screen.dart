import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zendy/helpers/helpers.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: _buildBody(),
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

import 'package:flutter/material.dart';
import 'package:local_notification/flutter_local_notifications/services/notification_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Local notification"),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                NotificationService().showNotification(
                  body: "bu boyd",
                  title: "bu title",
                );
              },
              child: Text("Show notification"))
        ],
      ),
    );
  }
}

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:local_notification/awesome_notifications/service/awesome_notification_service.dart';
import 'package:local_notification/awesome_notifications/widgets/notification_button.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // TextButton(
          //   onPressed: () {
          //     AwesomeNotifications().requestPermissionToSendNotifications();
          //   },
          //   child: Text("Request permission"),
          // ),
          // TextButton(
          //   onPressed: () {
          //     AwesomeNotifications().createNotification(
          //       content: NotificationContent(
          //         id: 1,
          //         channelKey: "mainKey",
          //         title: "bu title",
          //         body: "bu body",
          //         bigPicture: "asset://assets/bell.png",
          //         notificationLayout: NotificationLayout.BigPicture,
          //       ),
          //     );
          //   },
          //   child: Text("create"),
          // ),
          // TextButton(
          //   onPressed: () {
          //     AwesomeNotifications().createNotification(
          //       content: NotificationContent(
          //         id: 1,
          //         channelKey: "schedulek",
          //         title: "bu schedule title",
          //         body: "bu body",
          //         bigPicture: "asset://assets/bell.png",
          //         notificationLayout: NotificationLayout.BigPicture,
          //       ),
          //       schedule: NotificationCalendar.fromDate(
          //         date: DateTime.now().add(
          //           Duration(seconds: 5),
          //         ),
          //       ),
          //     );
          //   },
          //   child: Text("schedule"),
          // ),

          NotificationButton(
              onPressed: () async {
                await AwesomeNotificationService.showNotification(
                  body: "bu body",
                  title: "bu title",
                  summary: "bu summary",
                  notificationLayout: NotificationLayout.Default,
                  category: NotificationCategory.Reminder,
                  scheduled: true,
                  interval: 6,
                );
              },
              buttontext: ""),
        ],
      ),
    );
  }
}

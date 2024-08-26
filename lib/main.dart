import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:local_notification/awesome_notifications/second_screen.dart';
import 'package:local_notification/flutter_local_notifications/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  AwesomeNotifications().initialize("resource://drawable/bell", [
    NotificationChannel(
      channelKey: "mainKey",
      channelName: "mainName",
      channelDescription: "mainDesc",
      playSound: true,
      channelShowBadge: true,
      enableVibration: true,
      criticalAlerts: true,
    ),
    NotificationChannel(
      channelKey: "schedulek",
      channelName: "scheduleName",
      channelDescription: "scheduleDesc",
      playSound: true,
      channelShowBadge: true,
      importance: NotificationImportance.High,
    ),
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SecondScreen(),
    );
  }
}

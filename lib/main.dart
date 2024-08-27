import 'package:flutter/material.dart';
import 'package:local_notification/awesome_notifications/screens/second_screen.dart';
import 'package:local_notification/awesome_notifications/service/awesome_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AwesomeNotificationService.initializeNoifi();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: SecondScreen(),
    );
  }
}

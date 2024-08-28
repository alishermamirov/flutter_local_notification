import 'package:flutter/material.dart';
import 'package:local_notification/flutter_local_notifications/home_screen.dart';
import 'package:local_notification/flutter_local_notifications/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   NotificationService().init();
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
      home: HomeScreen(),
    );
  }
}

import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // Future<void> initNotification() async {
  //   AndroidInitializationSettings initializationSettingsAndroid =
  //       const AndroidInitializationSettings("bell");
  //   var initializationSettingsIOS = DarwinInitializationSettings(
  //     requestAlertPermission: true,
  //     requestBadgePermission: true,
  //     requestSoundPermission: true,
  //     onDidReceiveLocalNotification: (id, title, body, payload) async {},
  //   );
  //   var initializationSettings = InitializationSettings(
  //     android: initializationSettingsAndroid,
  //     iOS: initializationSettingsIOS,
  //   );
  //   flutterLocalNotificationsPlugin.initialize(
  //     initializationSettings,
  //     onDidReceiveNotificationResponse: (details) {},
  //     onDidReceiveBackgroundNotificationResponse:
  //         (NotificationResponse notificationResponse) {},
  //   );
  // }

  // void onDidReceiveNotificationResponse(
  //     NotificationResponse notificationResponse) async {
  //   final String? payload = notificationResponse.payload;
  //   if (notificationResponse.payload != null) {
  //     log('notification payload: $payload');
  //   }
  //   // await Navigator.push(
  //   //   context,
  //   //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
  //   // );
  // }

  // notificationDetails() {
  //   return const NotificationDetails(
  //     android: AndroidNotificationDetails(
  //       "prayer time",
  //       "channelName",
  //       importance: Importance.max,
  //       priority: Priority.high,
  //       ticker: 'ticker',
  //     ),
  //     iOS: DarwinNotificationDetails(),
  //   );
  // }

  // Future showNotification(
  //     {int id = 0, String? title, String? body, String? payload}) async {
  //   return flutterLocalNotificationsPlugin.show(
  //       id, title, body, notificationDetails());
  // }

  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    await _configureLocalTimeZone();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('bell');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: (details) {},
      onDidReceiveNotificationResponse: (details) {},
      // onDidReceiveBackgroundNotificationResponse: _onSelectNotification,
    );

    await checkNotification();
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();

    tz.setLocalLocation(tz.getLocation("Asia/Tashkent"));
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> showPrayerNotification(
      {required int id,
      required String title,
      required String body,
      required Duration duration}) async {
    /// android customisation notification

    /// ios customisation notification

    /// scheduled notification function
    print(tz.TZDateTime.now(tz.local).add(duration));

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(duration),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'prayer time',
          'prayer time',
          importance: Importance.max,
          priority: Priority.high,
          ongoing: true,
          //icon:
          // sound: RawResourceAndroidNotificationSound('slow_spring_board'),
          // when:
          ticker: 'prayer time',
          visibility: NotificationVisibility.public,
          category: AndroidNotificationCategory.reminder,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
    flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      payload: " ",
      NotificationDetails(
        android: AndroidNotificationDetails(
          'prayer time',
          'prayer time',
          importance: Importance.max,
          //icon:
          // sound: RawResourceAndroidNotificationSound('slow_spring_board'),
          // when:
          ticker: 'prayer time',
          visibility: NotificationVisibility.public,
          category: AndroidNotificationCategory.reminder,
        ),
      ),
    );
  }

  Future<void> checkNotification() async {
    final available =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    available.forEach(
      (element) {
        print(element.title);
        print(element.body);
      },
    );
    log(available.length.toString());
  }
}

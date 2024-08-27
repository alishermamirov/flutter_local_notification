import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:local_notification/flutter_local_notifications/home_screen.dart';
import 'package:local_notification/main.dart';

class AwesomeNotificationService {
  static Future<void> initializeNoifi() async {
    await AwesomeNotifications().initialize(null, debug: true, [
      NotificationChannel(
        channelKey: "mainKey",
        channelName: "mainName",
        channelDescription: "mainDesc",
        playSound: true,
        channelShowBadge: true,
        enableVibration: true,
        criticalAlerts: true,
        onlyAlertOnce: true,
        importance: NotificationImportance.Max,
      ),
      NotificationChannel(
        channelKey: "schedulek",
        channelName: "scheduleName",
        channelDescription: "scheduleDesc",
        playSound: true,
        channelShowBadge: true,
        importance: NotificationImportance.Max,
      ),
    ]);
    await AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) async {
        if (!isAllowed) {
          await AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );
    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }


  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    log("onNotificationCreatedMethod");
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    log("onActionReceivedMethod");
    final payload = receivedAction.payload ?? {};
    if (payload["navigate"] == "true") {
      MyApp.navigatorKey.currentState!.push(MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ));
    }
  }

  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    log("onNotificationDisplayedMethod");
  }

  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    log("onDismissActionReceivedMethod");
  }

  static Future<void> showNotification({
    required String title,
    required String body,
    String? summary,
    Map<String, String>? payload,
    ActionType actionType = ActionType.Default,
    NotificationLayout notificationLayout = NotificationLayout.Default,
    NotificationCategory? category,
    String? bigPicture,
    List<NotificationActionButton>? actionButtons,
    bool scheduled = false,
    int? interval,
  }) async {
    assert(!scheduled || (scheduled && interval != null));
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1,
        body: body,
        title: title,
        channelKey: "mainKey",
        actionType: actionType,
        notificationLayout: notificationLayout,
        summary: summary,
        category: category,
        payload: payload,
        bigPicture: bigPicture,
      ),
      actionButtons: actionButtons,
      schedule: scheduled
          ? NotificationCalendar.fromDate(
              date: DateTime.now().add(Duration(seconds: interval!)))
          : null,
    );
  }
}

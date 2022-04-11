import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:get/route_manager.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();
  // lutter_local_notifications: ^9.1.4
  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/Detroit'));
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    IOSInitializationSettings initializationSettingsIOS =
        const IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  final AndroidNotificationDetails _androidNotificationDetails =
      const AndroidNotificationDetails(
    'channel ID',
    'channel name',
    playSound: true,
    color: Colors.black,
    importance: Importance.high,
  );

  final IOSNotificationDetails _iosNotificationDetails =
      const IOSNotificationDetails(
    subtitle: "IOS SUBTITLE",
    badgeNumber: 0,
    presentSound: true,
  );

  Future<void> showNotifications(int id, String title, String body) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      "$title",
      "$body",
      NotificationDetails(
          android: _androidNotificationDetails, iOS: _iosNotificationDetails),
    );
  }

  Future<void> scheduleNotifications(int id, String title, String body) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        "$title",
        "$body",
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
        NotificationDetails(
            android: _androidNotificationDetails, iOS: _iosNotificationDetails),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

void selectNotification(String? payload) {
  debugPrint("HGello");
  Get.to(Scaffold(
    appBar: AppBar(
      title: Text("Hello"),
    ),
  ));
}

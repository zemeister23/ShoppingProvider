import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:localnotification/services/notification_service.dart';
import 'package:overlay_support/overlay_support.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final NotificationService _notificationService = NotificationService();
  late final FirebaseMessaging _messaging;
  String _data = "notData";

  @override
  void initState() {
    super.initState();
    registerNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("Push Notification"),
              onPressed: () {
                _notificationService.showNotifications(
                    3, "Text title", "Text Body");
              },
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              child: const Text("Schedule Notification"),
              onPressed: () {
                _notificationService.scheduleNotifications(
                    4, "Text title schedule", "Text Body schedule");
              },
            ),
            const SizedBox(height: 40.0),
            Text(_data),
          ],
        ),
      ),
    );
  }

  void registerNotification() async {
    // 1. Initialize the Firebase app

    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        setState(() {
          _data = message.notification!.title.toString();
          _notificationService.showNotifications(
              10,
              message.notification!.title.toString(),
              message.notification!.body.toString());
        });
        debugPrint("MESSAGE HAS SUCCESFULLY RECEIVED !");
      });
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }
}

class _messaging {}

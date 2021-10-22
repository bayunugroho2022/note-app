import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:noteapp/app/helpers/local_notification_service.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  bool first = false;
  first = !first;
  if(first){
    if (message.notification != null)
    {
      LocalNotificationService.display(message);
    }
  }
 }

class FcmService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  void initFCM(BuildContext context) {
    /// handles the message when user taps on the notification
    /// and runs the app from the terminated state
    getInitialMessage(context);

    /// when app works on foreground
    onMessage(context);

    /// when app is open on background and if only user taps on the notification
    onMessageOpenedApp(context);
  }


  /// handles the message when user taps on the notification
  /// and runs the app from the terminated state
  void getInitialMessage(BuildContext context) {
    _fcm.getInitialMessage().then((message) {
      if (message != null) {

      }
    });
  }
  void onBackgroundMessageHandler() {
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  }

  /// when app works on foreground
  void onMessage(BuildContext context) {
    print('foreground');
    FirebaseMessaging.onMessage.listen((message) => {
      if (message.notification != null)
        {
          LocalNotificationService.display(message),
        }
    });
  }

  /// when app is open on background and if only user taps on the notification
  void onMessageOpenedApp(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      /// in case a route key:data pair sent in the data message
      final routeFromMessage = message.data['route'];
      Navigator.of(context).pushNamed(routeFromMessage);
    });
  }
}
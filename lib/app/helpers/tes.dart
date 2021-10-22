import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Initialize firebase messaging
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

class FirebaseConfig {
  static late GlobalKey<NavigatorState> _globalKey;

  FirebaseConfig(GlobalKey<NavigatorState> globalKey) {
    _globalKey = globalKey;
  }

  static Future<void> topLevelHandler() async {
    // await Firebase.initializeApp();

    // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: openNotificationForeground);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
  }

  static Future<void> initialMessageHandler() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();
  }

  static Future<void> showNotificationForeground() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.data['image'] != null) {
        final ByteArrayAndroidBitmap largeIcon = ByteArrayAndroidBitmap(
            await _getByteArrayFromUrl('${message.data['image']}'));
        final ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(
            await _getByteArrayFromUrl('${message.data['image']}'));

        final BigPictureStyleInformation bigPictureStyleInformation =
            BigPictureStyleInformation(bigPicture,
                htmlFormatContentTitle: true,
                htmlFormatSummaryText: true);
        final AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
                'high_importance_channel', // id
                'High Importance Notifications', // title
                'This channel is used for important notifications.', // description
                styleInformation: bigPictureStyleInformation);
        final NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
          message.ttl!,
          message.notification!.title,
          message.notification!.body,
          platformChannelSpecifics,
          payload: jsonEncode(message.data),
        );
      } else {
        flutterLocalNotificationsPlugin.show(
          message.ttl!,
          message.notification!.title,
          message.notification!.body,
          platformChannelSpecifics,
          payload: jsonEncode(message.data),
        );
      }
    });
  }

  static Future<dynamic> openNotificationForeground(String? payload) async {
    await Firebase.initializeApp();

    log("PAYLOAD DATA PAYLOAD: $payload");
    if (payload == null) {
      return;
    }
    Map<String, dynamic> data = jsonDecode(payload);
    log("PAYLOAD DATA : $data");
    print('PAYLOAD DATA : Navigate to other screen ');
  }

  /// Define a top-level named handler which background/terminated messages will
  /// call.
  ///
  /// To verify things are working, check out the native platform logs.
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage((message) async{
      Map<String, dynamic> data = message.data;

      print('Handling a background message ${message.messageId}');
    });
  }

  static Future<void> onMessageOpenApp() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('A new onMessageOpenedApp event was published!');
      Map<String, dynamic> data = message.data;
      if (data.isNotEmpty) {
        print('PAYLOAD DATA : Navigate to other screen ');
      }
    });
  }
}

/// Create a [AndroidNotificationDetails] for heads up notifications
const androidPlatformChannelSpecifics = AndroidNotificationDetails(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  icon: '@mipmap/ic_launcher',
  importance: Importance.max,
  priority: Priority.high,
  showWhen: false,
);

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

const initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

final initializationSettingsIOS = IOSInitializationSettings();

final initializationSettings = InitializationSettings(
  android: initializationSettingsAndroid,
  iOS: initializationSettingsIOS,
);

const platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: IOSNotificationDetails(presentAlert: true, presentSound: true));

const channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.max,
  showBadge: true,
);

Future<Uint8List> _getByteArrayFromUrl(String url) async {
  final http.Response response = await http.get(Uri.parse(url));
  return response.bodyBytes;
}

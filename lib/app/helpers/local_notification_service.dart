import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'));

    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (payload) async {
          print('payload: $payload');
          Navigator.of(context).pushNamed('$payload');
        });
  }

  static void display(RemoteMessage message) async {
    try {
      final ByteArrayAndroidBitmap largeIcon = ByteArrayAndroidBitmap(
          await getByteArrayFromUrl('https://glints.com/id/lowongan/wp-content/uploads/2021/02/pengertian-flutter.png'));

      if(message.data['image'] == null){
        final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
              "high_importance_channel",
              "high_importance_channel channel",
              "this is our channel",
              importance: Importance.max,
              visibility: NotificationVisibility.public,
              priority: Priority.high,
          ),
        );
        await _notificationsPlugin.show(
          message.notification.hashCode,
          message.notification!.title,
          message.notification!.body,
          notificationDetails,
          payload: message.data['route'],
        );
      }else{
        final ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(
            await getByteArrayFromUrl(message.data['image']));
        final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(bigPicture);

        final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
              "high_importance_channel",
              "high_importance_channel channel",
              "this is our channel",
              importance: Importance.max,
              visibility: NotificationVisibility.public,
              priority: Priority.high,
              styleInformation:bigPictureStyleInformation
          ),
        );
        await _notificationsPlugin.show(
          message.notification.hashCode,
          message.notification!.title,
          message.notification!.body,
          notificationDetails,
          payload: message.data['route'],
        );
      }



    } on Exception catch (e) {
      print(e);
    }
  }

}

Future<Uint8List> getByteArrayFromUrl(String url) async {
  final http.Response response = await http.get(Uri.parse(url));
  return response.bodyBytes;
}
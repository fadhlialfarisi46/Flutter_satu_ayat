import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:satu_ayat/data/model/ayat.dart';
import 'package:satu_ayat/data/responses/detail_ayat_result.dart';

import '../common/navigation_route.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
    const AndroidInitializationSettings('img');

    var initializationSetting =
    InitializationSettings(android: initializationSettingsAndroid);

    // TODO
    // await flutterLocalNotificationsPlugin.initialize(initializationSetting,
    //     onSelectNotification: (String? payload) async {
    //       if (payload != null) {
    //         if (kDebugMode) {
    //           print('notification payload: $payload');
    //         }
    //       }
    //       selectNotificationSubject.add(payload ?? 'empty payload');
    //     });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      Ayat ayat) async {
    var _channelId = "1";
    var _channelName = "channel_1";
    var _channelDescription = "restaurant app channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));

    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    var titleNotification = "<b>Check this Restaurant!</b>";
    var contentNotifaction = ayat.arab;

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, contentNotifaction, platformChannelSpecifics,
        payload: jsonEncode(ayat.toJson()));
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen((event) async {
      var data = DetailAyatResult.fromJson(json.decode(event));
      Navigation.intentWithData(route, data);
    });
  }
}


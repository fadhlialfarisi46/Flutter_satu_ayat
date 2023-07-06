import 'dart:convert';

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
    const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = const DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false
    );

    var initializationSetting = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS
    );

    // TODO
    await flutterLocalNotificationsPlugin.initialize(initializationSetting,
    onDidReceiveNotificationResponse: (NotificationResponse details) async {
      final payload = details.payload;
      if (payload != null) {
        print('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      Ayat ayat) async {
    var _channelId = "1";
    var _channelName = "channel_1";
    var _channelDescription = "1 ayat channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, channelDescription: _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics
    );

    var titleNotification = "<b>Check this ayat!</b>";
    var contentNotifaction = ayat.translation;

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

import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';

import '../data/api/api_service.dart';
import '../main.dart';
import 'notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _sendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  static Future<void> callback() async {
    if (kDebugMode) {
      print('Alarm fired');
    }

    final NotificationHelper _notificationhelper = NotificationHelper();

    var result = await ApiService().getDetailAyat();
    var restaurant = result;

    await _notificationhelper.showNotification(
        flutterLocalNotificationsPlugin, restaurant);

    _sendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _sendPort?.send(null);
  }
}

import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:satu_ayat/common/navigation_route.dart';
import 'package:satu_ayat/data/api/api_service.dart';
import 'package:satu_ayat/data/db/db_helper.dart';
import 'package:satu_ayat/data/model/ayat.dart';
import 'package:satu_ayat/provider/database_provider.dart';
import 'package:satu_ayat/provider/detail_ayat_provider.dart';
import 'package:satu_ayat/provider/preferences_provider.dart';
import 'package:satu_ayat/provider/scheduling_provider.dart';
import 'package:satu_ayat/ui/detail_page.dart';
import 'package:satu_ayat/ui/home_page.dart';
import 'package:satu_ayat/utils/background_service.dart';
import 'package:satu_ayat/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/preferences/preferences_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if(Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await _notificationHelper.initNotification(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DetailAyatProvider(apiService: ApiService())),
        ChangeNotifierProvider(create: (_) => DatabaseProvider(dbHelper: DbHelper())),
        ChangeNotifierProvider(
            create: (_) => PreferencesProvider(
                preferencesHelper: PreferencesHelper(
                    sharedPreferences: SharedPreferences.getInstance()))),
        ChangeNotifierProvider(create: (_) => SchedulingProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        title: "demo",
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        navigatorKey: navigatorKey,
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          DetailPage.routeName: (context) {
            final arg = ModalRoute.of(context)?.settings.arguments as Ayat;
            return DetailPage(ayat: arg);
          }
        },
      ),
    );
  }


}
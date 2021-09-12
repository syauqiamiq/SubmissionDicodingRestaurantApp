import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/services/api_services.dart';
import 'package:restaurant_app/services/db/database_helper.dart';
import 'package:restaurant_app/services/utils/background_service.dart';
import 'package:restaurant_app/services/utils/notification_helper.dart';
import 'package:restaurant_app/view/favorite_restaurant.dart';
import 'package:restaurant_app/view/main_screen.dart';
import 'package:restaurant_app/view/restaurant.dart';
import 'package:restaurant_app/view/restaurant_detail.dart';
import 'package:restaurant_app/view/restaurant_search_screen.dart';
import 'package:restaurant_app/view/setting_page.dart';
import 'package:restaurant_app/view/splash_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider(apiService: ApiServices()),
        ),
        ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (_) => SchedulingProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        navigatorKey: navigatorKey,
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          RestaurantScreen.routeName: (context) => RestaurantScreen(),
          RestaurantDetailScreen.routeName: (context) => RestaurantDetailScreen(
              restoId: ModalRoute.of(context)?.settings.arguments as String),
          RestaurantSearchScreen.routeName: (context) =>
              RestaurantSearchScreen(),
          FavoriteRestaurantScreen.routeName: (context) =>
              FavoriteRestaurantScreen(),
          MainScreen.routeName: (context) => MainScreen(),
          SettingScreen.routeName: (context) => SettingScreen(),
        },
      ),
    );
  }
}

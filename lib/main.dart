import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dcd_restaurant_app/api/api_service.dart';
import 'package:dcd_restaurant_app/data/preference_helper.dart';
import 'package:dcd_restaurant_app/pages/detail_page.dart';
import 'package:dcd_restaurant_app/pages/favorite_page.dart';
import 'package:dcd_restaurant_app/pages/home_page.dart';
import 'package:dcd_restaurant_app/pages/search_page.dart';
import 'package:dcd_restaurant_app/pages/settings_page.dart';
import 'package:dcd_restaurant_app/pages/splash_page.dart';
import 'package:dcd_restaurant_app/provider/db_provider.dart';
import 'package:dcd_restaurant_app/provider/preference_provider.dart';
import 'package:dcd_restaurant_app/provider/restaurants_provider.dart';
import 'package:dcd_restaurant_app/provider/schedulling_provider.dart';
import 'package:dcd_restaurant_app/shared/navigation.dart';
import 'package:dcd_restaurant_app/shared/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/background_service.dart';
import 'utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) {}
  await AndroidAlarmManager.initialize();
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DbProvider()),
        ChangeNotifierProvider(
            create: (_) => RestaurantsProvider(apiService: ApiService())),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider(
            create: (_) => PreferencesProvider(
                preferencesHelper: PreferencesHelper(
                    sharedPreferences: SharedPreferences.getInstance()))),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        initialRoute: SplashPage.routeName,
        theme: ThemeData(
          textTheme: myTextTheme,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryColor,
                onPrimary: textColor,
              ),
        ),
        routes: {
          SplashPage.routeName: (context) => const SplashPage(),
          HomePage.routeName: (context) => const HomePage(),
          DetailPage.routeName: (context) => DetailPage(
                restaurantId:
                    ModalRoute.of(context)?.settings.arguments as String,
              ),
          SearchPage.routeName: (context) => const SearchPage(),
          SettingsPage.routeName: (context) => const SettingsPage(),
          FavoritePage.routeName: (context) => const FavoritePage(),
        },
      ),
    );
  }
}

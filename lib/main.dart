import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yess_nutrion/api/api_service.dart';
import 'package:yess_nutrion/common/navigation.dart';
import 'package:yess_nutrion/common/styles.dart';
import 'package:yess_nutrion/db/database_helper.dart';
import 'package:yess_nutrion/model/resto.dart';
import 'package:yess_nutrion/preferences/preferences_helper.dart';
import 'package:yess_nutrion/provider/database_provider.dart';
import 'package:yess_nutrion/provider/detail_provider.dart';
import 'package:yess_nutrion/provider/preferences_provider.dart';
import 'package:yess_nutrion/provider/resto_provider.dart';
import 'package:yess_nutrion/provider/scheduling_provider.dart';
import 'package:yess_nutrion/provider/search_provider.dart';
import 'package:yess_nutrion/ui/favorite_page.dart';
import 'package:yess_nutrion/ui/main_page.dart';
import 'package:yess_nutrion/ui/resto_detail.dart';
import 'package:yess_nutrion/ui/resto_search.dart';
import 'package:yess_nutrion/ui/setting_page.dart';
import 'package:yess_nutrion/ui/splash_screen.dart';
import 'package:yess_nutrion/utils/background_service.dart';
import 'package:yess_nutrion/utils/notification_helper.dart';
import 'package:yess_nutrion/widget/nav_bar.dart';

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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => RestoProvider(apiService: ApiService()),
          ),
          ChangeNotifierProvider(
            create: (_) =>
                RestoDetailProvider(apiService: ApiService(), id: ''),
          ),
          ChangeNotifierProvider(
            create: (_) => SearchRestoProvider(apiService: ApiService()),
          ),
          ChangeNotifierProvider(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
          ),
          ChangeNotifierProvider<SchedulingProvider>(
            create: (_) => SchedulingProvider(),
          ),
          ChangeNotifierProvider<PreferencesProvider>(
            create: (_) => PreferencesProvider(
              preferencesHelper: PreferencesHelper(
                sharedPreferences: SharedPreferences.getInstance(),
              ),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Restaurant App',
          theme: ThemeData(
            textTheme: myTextTheme,
            colorScheme: Theme.of(context).colorScheme.copyWith(),
            // primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          navigatorKey: navigatorKey,
          initialRoute: SettingPageResto.routeName,
          routes: {
            MainPage.routeName: (context) => MainPage(),
            SettingPageResto.routeName: (context) => MainPage(),
            RecomendResto.routeName: (context) => RecomendResto(),
            SearchResto.routeName: (context) => SearchResto(),
            FavoritePage.routeName: (context) => FavoritePage(),
            DetailResto.routeName: (context) => DetailResto(
                resto:
                    ModalRoute.of(context)?.settings.arguments as Restaurant),
            SplashScreen.routeName: (context) => SplashScreen(),
          },
        ));
  }
}

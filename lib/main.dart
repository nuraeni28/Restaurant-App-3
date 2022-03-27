import 'package:flutter/material.dart';
import 'package:yess_nutrion/model/resto.dart';
import 'package:yess_nutrion/main_page.dart';
import 'package:yess_nutrion/resto_detail.dart';
import 'package:yess_nutrion/resto_search.dart';
import 'package:yess_nutrion/splash_screen.dart';
import 'package:yess_nutrion/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        textTheme: myTextTheme,
        colorScheme: Theme.of(context).colorScheme.copyWith(),
        // primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        RecomendResto.routeName: (context) => RecomendResto(),
        SearchResto.routeName: (context) => SearchResto(),
        DetailResto.routeName: (context) => DetailResto(
            id: ModalRoute.of(context)!.settings.arguments == null
                ? 'null'
                : ModalRoute.of(context)!.settings.arguments as String),
        SplashScreen.routeName: (context) => SplashScreen(),
      },
    );
  }
}

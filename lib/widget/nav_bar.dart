import 'package:flutter/material.dart';
import 'package:yess_nutrion/ui/favorite_page.dart';
import 'package:yess_nutrion/ui/recomend_resto.dart';

import '../ui/setting_page.dart';

class MainPage extends StatefulWidget {
  static const routeName = '/main_page';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  int currentIndex = 0;
  final pages = [RecomendResto(), FavoritePage(), SettingPageResto()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, //
          selectedItemColor: Color(0xff00b894),
          unselectedItemColor: Colors.grey,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favorite'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Setting'),
          ]),
    );
  }
}

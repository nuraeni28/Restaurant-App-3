import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yess_nutrion/ui/main_page.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);
  static const routeName = '/splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 3),
  )..forward();
  late Animation<double> _animation =
      Tween(begin: 1.0, end: 0.0).animate(_controller);
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, RecomendResto.routeName);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FadeTransition(
      opacity: _animation,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFA5E4DC), Color(0xFF53EEDA)])),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image radius
                  Image.asset(
                    'images/launch_img.png',
                    fit: BoxFit.cover,
                    width: 300,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

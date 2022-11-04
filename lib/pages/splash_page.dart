import 'dart:async';
import 'dart:math' as math;

import 'package:dcd_restaurant_app/pages/home_page.dart';
import 'package:dcd_restaurant_app/shared/styles.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/splash_page';

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final Tween<double> _animationTween = Tween(begin: 0, end: math.pi * 2);

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4),
        () => Navigator.pushReplacementNamed(context, HomePage.routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
          child: TweenAnimationBuilder(
              tween: _animationTween,
              duration: const Duration(seconds: 3),
              builder: (context, double value, child) {
                return Transform.rotate(
                  angle: value,
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/restaurant_logo.png',
                        ),
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}

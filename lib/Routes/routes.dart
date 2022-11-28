// ignore_for_file: depend_on_referenced_packages

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_authentication/Login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => AnimatedSplashScreen(
                  splash: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/Firiririri1.png', height: 200, width: 180),
                        const SizedBox(height: 40),
                        const CircularProgressIndicator(),
                      ],
                    ),
                  ),
                  duration: 3000,
                  splashIconSize: double.maxFinite,
                  pageTransitionType: PageTransitionType.fade,
                  nextScreen: const Login(),
                ));
      case "home":
        return MaterialPageRoute(builder: (_) => const Login());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:boba_time/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
          splash: "assets/images/logo.png",
          duration: 1000,
          splashTransition: SplashTransition.rotationTransition,
          backgroundColor: Color.fromRGBO(56, 56, 56, 0.4),
          pageTransitionType: PageTransitionType.rightToLeftWithFade,
          nextScreen: AppStartingPage()),
    );
  }
}

class AppStartingPage extends StatelessWidget {
  const AppStartingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LandingScreen();
  }
}

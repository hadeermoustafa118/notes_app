
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/presentation/colorManager.dart';
import 'package:notes_app/screens/signUp.dart';

import 'login.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({Key? key, required this.start}) : super(key: key);

Widget start;
  @override
  Widget build(BuildContext context) {

    return AnimatedSplashScreen(
      splash:
           Image.asset(
        'assets/images/images.png',
      ),

      splashIconSize: 270,
      nextScreen: start,
      splashTransition: SplashTransition.scaleTransition,
      backgroundColor: ColorManager.lightColor,
      duration: 1000,
      animationDuration: Duration(seconds: 1),
    );
  }
}

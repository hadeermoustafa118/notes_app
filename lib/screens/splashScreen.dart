
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:notes_app/presentation/colorManager.dart';
import 'package:notes_app/screens/signUp.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant.dart';
import 'login.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({Key? key, required this.start}) : super(key: key);

Widget start;
  @override
  Widget build(BuildContext context) {

    return AnimatedSplashScreen(
      splash:
           Center(child: Text('Notes App', style: GoogleFonts.pacifico(color: isDark?ColorManager.txtLight:ColorManager.txtColor, fontSize: 32.0.sp),)),

      splashIconSize: 270,
      nextScreen: start,
      splashTransition: SplashTransition.scaleTransition,
      backgroundColor:isDark? ColorManager.dartColor: ColorManager.lightColor,
      duration: 1000,
      animationDuration: Duration(seconds: 1),
    );
  }
}

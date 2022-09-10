import 'package:flutter/material.dart';
import 'package:notes_app/network/casheHelper.dart';
import 'package:notes_app/screens/login.dart';
import 'package:notes_app/screens/signUp.dart';
import 'package:notes_app/screens/splashScreen.dart';
import '../screens/homeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'constant.dart';

CollectionReference notesRef =
    FirebaseFirestore.instance.collection('flutterNotes');
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  isDark = CashHelper.getData(key: 'mode')!;
  debugPrint('$isDark');

  await Firebase.initializeApp();
  var userData = FirebaseAuth.instance.currentUser;
  Widget? widget;
  bool? isLogin;
  if (userData == null) {
    isLogin = false;
    widget = Login();
  } else {
    isLogin = true;
    widget = HomeScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.startWidget});
  Widget startWidget;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      minTextAdapt: true,
      designSize: const Size(411.4, 820.6),
      builder: (context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(
            start: startWidget,
          ),
        );
      },
    );
  }
}

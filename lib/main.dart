import 'package:flutter/material.dart';
import 'package:notes_app/network/casheHelper.dart';
import 'package:notes_app/screens/login.dart';
import 'package:notes_app/screens/signUp.dart';
import 'package:notes_app/screens/splashScreen.dart';
import 'package:notes_app/themes.dart';
import '../screens/homeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'constant.dart';
import 'package:easy_localization/easy_localization.dart';


CollectionReference notesRef =
    FirebaseFirestore.instance.collection('flutterNotes');
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
await CashHelper.init();
  isDark = CashHelper.getData(key: 'isDark')??false;
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
  runApp(EasyLocalization(
    path: 'assets/translations',
    supportedLocales: [
      Locale('en'),
      Locale('ar'),
    ],
    startLocale: Locale('en'),
    saveLocale: true,
    fallbackLocale: Locale('en'),
    child: MyApp(
      startWidget: widget,
    ),
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
          darkTheme: dark,
          theme: light,

          themeMode: isDark? ThemeMode.light :ThemeMode.dark,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          home: SplashScreen(
            start: startWidget,
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import '../screens/homeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      minTextAdapt: true,
      designSize: const Size(411.4, 820.6),
      builder: (context, Widget? child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        );
      },
    );
  }
}

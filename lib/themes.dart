import 'package:flutter/material.dart';
import 'package:notes_app/presentation/colorManager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData dark = ThemeData(
  scaffoldBackgroundColor: ColorManager.dartColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    backgroundColor: ColorManager.primaryColor,
    fixedSize: Size(60.w, 200.h),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0.r),
    ),
  )),
  backgroundColor: ColorManager.lightColor,
  appBarTheme: AppBarTheme(backgroundColor: ColorManager.dartColor),
  iconTheme: IconThemeData(
    color: ColorManager.lightColor,
    size: 25,
  ),
);
ThemeData light = ThemeData(
  scaffoldBackgroundColor: ColorManager.lightColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    backgroundColor: ColorManager.primaryColor,
    fixedSize: Size(60.w, 200.h),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0.r),
    ),
  )),
  backgroundColor: ColorManager.dartColor,
  appBarTheme: AppBarTheme(backgroundColor: ColorManager.lightColor),
  iconTheme: IconThemeData(
    color: ColorManager.dartColor,
    size: 25,
  ),
);

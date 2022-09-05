import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/appCubit.dart';

class CircleColor extends StatelessWidget {
  const CircleColor(
      {Key? key, required this.bgColor, this.radius = 35,required this.child,})
      : super(key: key);
  final Color bgColor;
  final double radius;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: bgColor,
      child: child,
      radius: radius.r,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleColor extends StatelessWidget {
  const CircleColor(
      {Key? key, required this.bgColor, this.radius = 35, this.tab = false})
      : super(key: key);
  final Color bgColor;
  final double radius;
  final bool tab;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: bgColor,
      child: tab
          ? Icon(Icons.done, color: Colors.black,)
          : CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 15.r,
            ),
      radius: radius.r,
    );
  }
}

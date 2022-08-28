import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FieldTitle extends StatelessWidget {
  const FieldTitle({Key? key, required this.text}) : super(key: key);
final String text;
  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0).r,
      child: Text(
      text,
        textAlign: TextAlign.start,
        style:
        TextStyle(fontSize: 18.sp, color: Colors.white),
      ),
    );
  }
}

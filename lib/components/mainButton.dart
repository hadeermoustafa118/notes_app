import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constant.dart';
import '../presentation/colorManager.dart';

class MainButton extends StatelessWidget {
  final String btnText;
  final double height;
  final Function press;
  final double width;
  bool enable;
  MainButton(
      {Key? key,
      this.enable = true,
      required this.btnText,
      required this.press,
      required this.height,
      required this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primaryColor,
          fixedSize: Size(width.w, height.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0.r),
          ),
        ),
        onPressed: () => enable ? press() : null,
        child: Text(
          btnText,
          style: TextStyle(
            fontSize: 17.sp,
            color: isDark? ColorManager.lightColor:ColorManager.dartColor,
          ),
        ).tr(),);
  }
}

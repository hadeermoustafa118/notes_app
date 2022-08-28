import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../presentation/colorManager.dart';

class NoteDetail extends StatelessWidget {
  const NoteDetail({Key? key, required this.notes}) : super(key: key);
final notes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50.0,
          ).r,
          child: Column(
            children: [
              SizedBox(
                height: 5.0.h,
              ),
              SizedBox(
                height: 180.h,
                width: 300.w,
                child: Image.asset('assets/images/view.png'),
              ),
              SizedBox(
                height: 16.0.h,
              ),
              Text("See More! ", style: GoogleFonts.pacifico(fontSize: 28.0.sp))
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 400.h,
        decoration: BoxDecoration(
            color: ColorManager.txtColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40).r,
                topRight: Radius.circular(40.0.r))),
        child:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notes['note_title'],
                style: TextStyle(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.primaryColor),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    notes['note_date'],
                    style: TextStyle(
                        fontSize: 18.sp, color: ColorManager.disabledColor),
                  ),
                  SizedBox(
                    width: 5.0.w,
                  ),
                  Text(
                    notes['note_time'],
                    style: TextStyle(
                        fontSize: 18.sp, color: ColorManager.disabledColor),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0.h,
              ),
              SingleChildScrollView(
                child: Text(
                  notes['note_content'],
                  style: TextStyle(
                    fontSize: 26.sp,
                    color: ColorManager.lightColor,
                    fontWeight: FontWeight.w400,

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

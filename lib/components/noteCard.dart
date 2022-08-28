import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/cubit/appCubit.dart';
import 'package:notes_app/cubit/appStates.dart';
import '../presentation/colorManager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteCard extends StatelessWidget {
   NoteCard({Key? key, required this.onTap, required this.index})
      : super(key: key);
  final Function onTap;
  final int index;
  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getData(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AppCubit.get(context);
            return InkWell(
              onTap: onTap(),
              child: Container(
                width: 120.w,
                height: 180.h,
                padding: EdgeInsets.all(16.0).r,
                margin: EdgeInsets.all(12.0).r,
                decoration: BoxDecoration(
                    color:
                        ColorManager.cardColors[cubit.notes[index]['color_id']],
                    borderRadius: BorderRadius.circular(20.0).r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cubit.notes[index]['note_title'],
                      style: TextStyle(
                          fontSize: 24.sp,
                          color: ColorManager.txtColor,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 8.0.h,
                    ),
                    Row(
                      children: [
                        Text(
                          cubit.notes[index]['note_date'],
                          style: TextStyle(
                              fontSize: 14.sp, color: ColorManager.txtColor),
                        ),
                        SizedBox(
                          width: 5.0.w,
                        ),
                        Text(
                          cubit.notes[index]['note_time'],
                          style: TextStyle(
                              fontSize: 14.sp, color: ColorManager.txtColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.0.h,
                    ),
                    Text(
                      cubit.notes[index]['note_content'],
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: ColorManager.txtColor,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

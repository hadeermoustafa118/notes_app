import 'package:flutter/material.dart';
import 'package:notes_app/components/myTextField.dart';
import 'package:notes_app/cubit/appCubit.dart';
import 'package:notes_app/cubit/appStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constant.dart';
import '../presentation/colorManager.dart';
import 'noteDetails.dart';
import 'package:easy_localization/easy_localization.dart';
class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit(),
        child: BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = AppCubit.get(context);
              return Scaffold(
                backgroundColor: isDark? ColorManager.dartColor: ColorManager.lightColor,
                body: SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      children: [
                        MyTextField(
                          txtColor: isDark? ColorManager.lightColor:ColorManager.dartColor,
                          submit: (text){
                            cubit.searchController.text= text;
                            cubit.searchByTitle();
                          },
                            enable: isDark? ColorManager.lightColor:ColorManager.dartColor,
                            focus: isDark? ColorManager.lightColor:ColorManager.dartColor,
                            hintStyle: Colors.grey,
                            hint: 'search'.tr(),
                            controller: cubit.searchController,
                            validatorText: 'search validate'.tr(),
                            icon: Icon(Icons.search, color: isDark? ColorManager.lightColor:ColorManager.dartColor,),
                            onTap: () {}),
                        if(cubit.notesResult.isNotEmpty)
                          SizedBox(
                          height: 800.h,
                          width: 400.w,
                          child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NoteDetail(
                                                        notes: cubit
                                                            .notesResult[index],
                                                      )),
                                            );
                                          },
                                          child: Container(
                                            padding:
                                                const EdgeInsets.all(16.0).r,
                                            margin:
                                                const EdgeInsets.all(12.0).r,
                                            decoration: BoxDecoration(
                                                color: ColorManager.cardColors[
                                                    cubit.notesResult[index]
                                                        ['color_id']],
                                                borderRadius:
                                                    BorderRadius.circular(20.0)
                                                        .r),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  cubit.notesResult[index]
                                                      ['note_title'],
                                                  style: TextStyle(
                                                      fontSize: 24.sp,
                                                      color:
                                                          ColorManager.txtColor,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  maxLines: 1,
                                                ),
                                                SizedBox(
                                                  height: 8.0.h,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      cubit.notesResult[index]
                                                          ['note_date'],
                                                      style: TextStyle(
                                                          fontSize: 14.sp,
                                                          color: ColorManager
                                                              .txtColor),
                                                    ),
                                                    SizedBox(
                                                      width: 5.0.w,
                                                    ),
                                                    Text(
                                                      cubit.notesResult[index]
                                                          ['note_time'],
                                                      style: TextStyle(
                                                          fontSize: 14.sp,
                                                          color: ColorManager
                                                              .txtColor),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 12.0.h,
                                                ),
                                                Text(
                                                  cubit.notesResult[index]
                                                      ['note_content'],
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    color:
                                                        ColorManager.txtColor,
                                                    fontWeight: FontWeight.w400,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                },
                                itemCount: cubit.notesResult.length,
                              )

                        )
                        else
                           Container(height: 500.h,
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('no data', style: TextStyle(color: isDark? ColorManager.lightColor:ColorManager.dartColor, fontSize: 20.sp),).tr(),
                              ],
                          ),
                           ),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}

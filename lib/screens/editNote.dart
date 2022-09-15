import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../components/circleColor.dart';
import '../components/fieldTitle.dart';
import '../components/mainButton.dart';
import '../components/myTextField.dart';
import '../components/textFieldForEdit.dart';
import '../constant.dart';
import '../cubit/appCubit.dart';
import '../cubit/appStates.dart';
import '../presentation/colorManager.dart';
import 'homeScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EditNote extends StatelessWidget {
  const EditNote(
      {Key? key,
      required this.docId,
      required this.noteList,
      required this.index})
      : super(key: key);
  final String docId;
  final noteList;
  final int index;
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
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50.0,
                    ).r,
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.0.h,
                          ),
                          SizedBox(
                            height: 100.h,
                            width: 150.w,
                            child: Image.asset('assets/images/77271.png'),

                          ),
SizedBox(height: 10.0.h,),
                          Text("take note",
                              style: GoogleFonts.pacifico(fontSize: 24.0.sp,color: isDark?ColorManager.txtLight:ColorManager.txtColor)).tr()
                        ],
                      ),
                    ),
                  ),
                ),
                bottomSheet: Container(
                  color: isDark? ColorManager.dartColor: ColorManager.lightColor,

                  child: Container(
                    height: 600.h,
                    decoration: BoxDecoration(
                        color: isDark? ColorManager.lightColor:ColorManager.dartColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40).r,
                            topRight: Radius.circular(40.0.r))),
                    child: SingleChildScrollView(
                      child: Form(
                        key: cubit.formKeyEditNote,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 40.0.h,
                              ),
                               FieldTitle(
                                text: 'title',
                              ),
                              TextFieldForEdit(
                                  save: (text) {
                                    cubit.title = text!;
                                  },
                                  hint: '',
                                  init: '${noteList[index]['note_title']}',
                                  validatorText: 'validate'.tr(),
                                  icon: Icon(
                                    Icons.title,
                                    color: isDark? ColorManager.dartColor:ColorManager.lightColor,
                                  ),
                                  onTap: () {}),
                              SizedBox(
                                height: 15.0.h,
                              ),
                               FieldTitle(
                                text: 'content',
                              ),
                              TextFieldForEdit(
                                  init: '${noteList[index]['note_content']}',
                                  hint: '',
                                  save: (text) {
                                    cubit.content = text!;
                                  },
                                  validatorText: 'validate'.tr(),
                                  icon: Icon(
                                    Icons.content_paste_rounded,
                                    color: isDark? ColorManager.dartColor:ColorManager.lightColor,
                                  ),
                                  onTap: () {}),
                              SizedBox(
                                height: 15.0.h,
                              ),
                               FieldTitle(text: 'color'),
                              SizedBox(
                                height: 10.0.h,
                              ),
                              Center(
                                child: SizedBox(
                                  height: 200.h,
                                  width: 300.w,
                                  child: GridView.count(
                                    crossAxisCount: 3,
                                    children: List.generate(
                                      ColorManager.cardColors.length,
                                      (index) {
                                        return InkWell(
                                          onTap: (){
                                            cubit.colorIndex = index;
                                            cubit.changeTabVale(index);
                                          },
                                          child: Center(
                                            child: CircleColor(
                                                bgColor: ColorManager
                                                    .cardColors[index],
                                                child: cubit.taby[index] ? Icon(Icons.done, color: isDark? ColorManager.txtLight:ColorManager.txtColor,):Container()),
                                          ),
                                        );

                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Center(
                                  child: MainButton(
                                      btnText: 'save',
                                      press: () {
                                        if (cubit.formKeyEditNote.currentState!
                                            .validate()) {
                                          cubit.editNote(
                                              colorId: cubit.colorIndex ??
                                                  noteList[index]['color_id'],
                                              noteTime: cubit.currentTimeEdit
                                                  .toString(),
                                              noteContent:
                                                  cubit.content ?? 'no content',
                                              noteDate: cubit.currentDateEdit
                                                  .toString(),
                                              userId: FirebaseAuth
                                                  .instance.currentUser!.uid,
                                              noteTitle:
                                                  cubit.title ?? 'no title',
                                              docId: docId);
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomeScreen()),
                                          );
                                        }
                                      },
                                      height: 60.h,
                                      width: 200.w)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}

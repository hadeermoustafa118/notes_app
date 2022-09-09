import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/components/circleColor.dart';
import 'package:notes_app/components/fieldTitle.dart';
import 'package:notes_app/components/mainButton.dart';
import 'package:notes_app/screens/homeScreen.dart';
import '../components/myTextField.dart';
import '../constant.dart';
import '../cubit/appCubit.dart';
import '../cubit/appStates.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../presentation/colorManager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNote extends StatelessWidget {
  const AddNote({Key? key}) : super(key: key);

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
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5.0.h,
                        ),
                        SizedBox(
                          height: 80.h,
                          width: 300.w,
                          child: Image.asset('assets/images/log.png'),
                        ),
                        SizedBox(
                          height: 16.0.h,
                        ),
                        Text("New Note! ",
                            style: GoogleFonts.pacifico(fontSize: 28.0.sp, color: isDark?ColorManager.txtLight:ColorManager.txtColor))
                      ],
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
                        key: cubit.formKeyNote,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 40.0.h,
                              ),
                              const FieldTitle(
                                text: 'Note Title',
                              ),
                              MyTextField(
                                focus:isDark? ColorManager.dartColor: ColorManager.lightColor ,
                                  enable: isDark? ColorManager.dartColor: ColorManager.lightColor ,
                                  txtColor: isDark? ColorManager.dartColor: ColorManager.txtColor,
                                  submit: (value) {},
                                  hint: '',
                                  controller: cubit.titleController,
                                  validatorText: 'This field can not be empty',
                                  icon: Icon(
                                    Icons.title,
                                    color: isDark? ColorManager.dartColor:ColorManager.lightColor,
                                  ),
                                  onTap: () {}),
                              SizedBox(
                                height: 15.0.h,
                              ),
                              const FieldTitle(
                                text: 'Note Content',
                              ),
                              MyTextField(       focus:isDark? ColorManager.dartColor: ColorManager.lightColor ,
                                  enable: isDark? ColorManager.dartColor: ColorManager.lightColor ,
                                  txtColor: isDark? ColorManager.dartColor: ColorManager.txtColor,
                                  submit: (value) {},
                                  hint: '',
                                  controller: cubit.contentController,
                                  validatorText: 'This field can not be empty',
                                  icon: Icon(
                                    Icons.content_paste_rounded,
                                    color:isDark? ColorManager.dartColor:ColorManager.lightColor,
                                  ),
                                  onTap: () {}),
                              SizedBox(
                                height: 15.0.h,
                              ),
                              const FieldTitle(text: 'Pick Colour'),
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
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Center(
                                  child: MainButton(
                                      btnText: 'Add',
                                      press: () {
                                        if (cubit.formKeyNote.currentState!
                                            .validate()) {
                                          cubit.addNote(
                                              colorId: cubit.colorIndex ?? 2,
                                              noteTime:
                                                  cubit.currentTime.toString(),
                                              noteContent:
                                                  cubit.contentController.text,
                                              noteDate:
                                                  cubit.currentDate.toString(),
                                              userId: FirebaseAuth
                                                  .instance.currentUser!.uid,
                                              noteTitle:
                                                  cubit.titleController.text);
                                          debugPrint(
                                              '${FirebaseAuth.instance.currentUser!.uid}');
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

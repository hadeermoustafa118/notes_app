import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes_app/components/mainButton.dart';
import 'package:notes_app/components/myTextField.dart';
import 'package:notes_app/cubit/appCubit.dart';
import 'package:notes_app/cubit/appStates.dart';
import 'package:notes_app/screens/homeScreen.dart';
import 'package:notes_app/screens/login.dart';
import '../constant.dart';
import '../presentation/colorManager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  UserCredential? userCredential;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            backgroundColor:isDark? ColorManager.dartColor: ColorManager.lightColor,

            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50.0,
                ).r,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30.0.h,
                    ),
                    SizedBox(
                      height: 140.h,
                      width: 300.w,
                      child: Image.asset('assets/images/77271.png'),

                    ),
                    SizedBox(
                      height: 26.0.h,
                    ),
                    Text("Let's Take Notes",
                        style: GoogleFonts.pacifico(fontSize: 28.0.sp,color: isDark?ColorManager.txtLight:ColorManager.txtColor))
                  ],
                ),
              ),
            ),
            bottomSheet: Container(
              color: isDark? ColorManager.dartColor: ColorManager.lightColor,
              child: Container(
                height: 460.h,
                decoration: BoxDecoration(
                    color: isDark? ColorManager.lightColor: ColorManager.dartColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40).r,
                        topRight: Radius.circular(40.0.r))),
                child: SingleChildScrollView(
                  child: Form(
                    key: cubit.formKeySign,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 16.0.h,
                        ),
                        Text(
                          'sign',
                          style:
                              TextStyle(fontSize: 40.0.sp, color: isDark? ColorManager.dartColor:ColorManager.lightColor),
                        ).tr(),
                        SizedBox(
                          height: 20.0.h,
                        ),
                        MyTextField(
                            submit: (value) {},
                            focus:isDark? ColorManager.dartColor: ColorManager.lightColor ,
                            enable: isDark? ColorManager.dartColor: ColorManager.lightColor ,
                            txtColor: isDark? ColorManager.dartColor: ColorManager.lightColor,
                            hintStyle: isDark
                                ? ColorManager.disabledColor
                                : ColorManager.lightColor,
                            hint: 'username'.tr(),
                            controller: cubit.usernameController,
                            validatorText: 'validate'..tr(),
                            icon: Icon(
                              Icons.person,
                              color: isDark
                                  ? ColorManager.dartColor
                                  : ColorManager.lightColor,
                            ),
                            onTap: () {}),
                        SizedBox(
                          height: 15.0.h,
                        ),
                        MyTextField(
                            submit: (value) {},
                            focus:isDark? ColorManager.dartColor: ColorManager.lightColor ,
                            enable: isDark? ColorManager.dartColor: ColorManager.lightColor ,
                            txtColor: isDark? ColorManager.dartColor: ColorManager.lightColor,
                            hintStyle: isDark
                                ? ColorManager.disabledColor
                                : ColorManager.lightColor,
                            hint: 'email'.tr(),
                            controller: cubit.emailController,
                            validatorText: 'validate'.tr(),
                            icon: Icon(
                              Icons.mail,
                              color: isDark
                                  ? ColorManager.dartColor
                                  : ColorManager.lightColor,
                            ),
                            onTap: () {}),
                        SizedBox(
                          height: 15.0.h,
                        ),
                        MyTextField(
                            submit: (value) {},
                            focus:isDark? ColorManager.dartColor: ColorManager.lightColor ,
                            enable: isDark? ColorManager.dartColor: ColorManager.lightColor ,
                            txtColor: isDark? ColorManager.dartColor: ColorManager.lightColor,
                            hintStyle: isDark
                                ? ColorManager.disabledColor
                                : ColorManager.lightColor,
                            hint: 'pass'.tr(),
                            controller: cubit.passController,
                            validatorText: 'validate'.tr(),
                            icon: Icon(
                              Icons.password,
                              color: isDark
                                  ? ColorManager.dartColor
                                  : ColorManager.lightColor,
                            ),
                            onTap: () {}),
                        SizedBox(
                          height: 20.0.h,
                        ),
                        MainButton(
                            btnText: 'sign',
                            press: () async {
                              try {
                                if (cubit.formKeySign.currentState!
                                    .validate()) {
                                  userCredential = await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: cubit.emailController.text,
                                          password: cubit.passController.text);
                                  debugPrint('$userCredential');
                                  cubit.addUserData(
                                      username: cubit.usernameController.text,
                                      mail: cubit.emailController.text);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()),
                                  );
                                }
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  AwesomeDialog(
                                          body: SizedBox(
                                            height: 100.h,
                                            child: Center(
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                'weak pass',
                                                style: TextStyle(
                                                    color: isDark
                                                        ? ColorManager.txtLight
                                                        : ColorManager.txtColor,
                                                    fontSize: 20.sp),
                                              ).tr(),
                                            ),
                                          ),
                                          context: context,
                                          dialogType: DialogType.WARNING)
                                      .show();
                                  debugPrint(
                                      'The password provided is too weak.');
                                } else if (e.code == 'email-already-in-use') {
                                  AwesomeDialog(
                                          body: SizedBox(
                                            height: 100.h,
                                            child: Center(
                                              child: Text(
                                                'mail in use',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: isDark
                                                        ? ColorManager.txtLight
                                                        : ColorManager.txtColor,
                                                    fontSize: 20.sp),
                                              ).tr(),
                                            ),
                                          ),
                                          context: context,
                                          dialogType: DialogType.WARNING)
                                      .show();

                                  debugPrint(
                                      'The account already exists for that email.');
                                }
                              } catch (e) {
                                debugPrint('$e');
                              }
                            },
                            height: 60.h,
                            width: 200.w),
                        SizedBox(
                          height: 8.0.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'have account',
                              style: TextStyle(
                                  color: isDark
                                      ? ColorManager.dartColor
                                      : ColorManager.lightColor),
                            ).tr(),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()),
                                  );
                                },
                                child: Text(
                                  'login',
                                  style: TextStyle(
                                      color: ColorManager.primaryColor,
                                      fontSize: 16.sp)
                                ).tr(),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

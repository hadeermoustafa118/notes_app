import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/screens/homeScreen.dart';
import 'package:notes_app/screens/signUp.dart';
import '../components/mainButton.dart';
import '../components/myTextField.dart';
import '../constant.dart';
import '../cubit/appCubit.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../cubit/appStates.dart';
import '../presentation/colorManager.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
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
                      height: 16.0.h,
                    ),
                    SizedBox(
                      height: 180.h,
                      width: 300.w,
                      child: Image.asset('assets/images/log.png'),
                    ),
                    SizedBox(
                      height: 16.0.h,
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
                height: 450.h,
                decoration: BoxDecoration(
                    color: isDark? ColorManager.lightColor: ColorManager.dartColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40).r,
                        topRight: Radius.circular(40.0.r))),
                child: SingleChildScrollView(
                  child: Form(
                    key: cubit.formKeyLogin,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 16.0.h,
                        ),
                        Text(
                          'Login',
                          style:
                              TextStyle(fontSize: 40.0.sp, color: isDark? ColorManager.dartColor:ColorManager.lightColor),
                        ),
                        SizedBox(
                          height: 20.0.h,
                        ),
                        MyTextField( submit: (value){},
                            focus:isDark? ColorManager.dartColor: ColorManager.lightColor ,
                            enable: isDark? ColorManager.dartColor: ColorManager.lightColor ,
                            txtColor: isDark? ColorManager.dartColor: ColorManager.txtColor,
                            hintStyle: isDark? ColorManager.disabledColor: ColorManager.lightColor,
                            hint: 'enter your e-mail',
                            controller: cubit.emailForLoginController,
                            validatorText: 'This field can not be empty',
                            icon: Icon(
                              Icons.mail,
                              color: isDark? ColorManager.dartColor:ColorManager.lightColor,
                            ),
                            onTap: () {}),
                        SizedBox(
                          height: 15.0.h,
                        ),
                        MyTextField( submit: (value){},
                            hintStyle: isDark? ColorManager.disabledColor: ColorManager.lightColor,
                            focus:isDark? ColorManager.dartColor: ColorManager.lightColor ,
                            enable: isDark? ColorManager.dartColor: ColorManager.lightColor ,
                            txtColor: isDark? ColorManager.dartColor: ColorManager.txtColor,
                            hint: 'enter your password',
                            controller: cubit.passForLoginController,
                            validatorText: 'This field can not be empty',
                            icon: Icon(
                              Icons.password,
                              color: isDark? ColorManager.dartColor:ColorManager.lightColor,
                            ),
                            onTap: () {}),
                        SizedBox(
                          height: 20.0.h,
                        ),
                        MainButton(
                            btnText: 'Login',
                            press: () async {
                              try {
                                if (cubit.formKeyLogin.currentState!.validate()) {
                                  userCredential = await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email:
                                              cubit.emailForLoginController.text,
                                          password:
                                              cubit.passForLoginController.text);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const HomeScreen()),
                                  );
                                }
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  AwesomeDialog(
                                          body: SizedBox(
                                            height: 100.h,
                                            child: Center(
                                              child: Text(
                                                'No user found for that email',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color:isDark? ColorManager.txtLight: ColorManager.txtColor,
                                                    fontSize: 20.sp),
                                              ),
                                            ),
                                          ),
                                          context: context,
                                          dialogType: DialogType.WARNING)
                                      .show();
                                  print('No user found for that email.');
                                } else if (e.code == 'wrong-password') {
                                  AwesomeDialog(
                                          body: SizedBox(
                                            height: 100.h,
                                            child: Center(
                                              child: Text(
                                                'Wrong password provided for that user.',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color:isDark? ColorManager.txtLight: ColorManager.txtColor,
                                                    fontSize: 20.sp),
                                              ),
                                            ),
                                          ),
                                          context: context,
                                          dialogType: DialogType.WARNING)
                                      .show();
                                  print('Wrong password provided for that user.');
                                }
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
                              'Do not have an account? ',
                              style: TextStyle(color: isDark? ColorManager.dartColor: ColorManager.lightColor),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUp()),
                                  );
                                },
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: ColorManager.primaryColor,
                                      fontSize: 16.sp),
                                )),
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

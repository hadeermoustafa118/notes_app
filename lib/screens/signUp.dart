import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes_app/components/mainButton.dart';
import 'package:notes_app/components/myTextField.dart';
import 'package:notes_app/cubit/appCubit.dart';
import 'package:notes_app/cubit/appStates.dart';
import 'package:notes_app/screens/homeScreen.dart';
import 'package:notes_app/screens/login.dart';
import '../presentation/colorManager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

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
                      child: Image.asset('assets/images/images.png'),
                    ),
                    SizedBox(
                      height: 16.0.h,
                    ),
                    Text("Let's Take Notes",
                        style: GoogleFonts.pacifico(fontSize: 28.0.sp))
                  ],
                ),
              ),
            ),
            bottomSheet: Material(
              child: Container(
                height: 460.h,
                decoration: BoxDecoration(
                    color: ColorManager.txtColor,
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
                          'Sign Up',
                          style:
                              TextStyle(fontSize: 40.0.sp, color: Colors.white),
                        ),
                        SizedBox(
                          height: 20.0.h,
                        ),
                        MyTextField(
                            hint: 'enter your username',
                            controller: cubit.usernameController,
                            validatorText: 'This field can not be empty',
                            icon: Icon(
                              Icons.person,
                              color: ColorManager.lightColor,
                            ),
                            onTap: () {}),
                        SizedBox(
                          height: 15.0.h,
                        ),
                        MyTextField(
                            hint: 'enter your e-mail',
                            controller: cubit.emailController,
                            validatorText: 'This field can not be empty',
                            icon: Icon(
                              Icons.mail,
                              color: ColorManager.lightColor,
                            ),
                            onTap: () {}),
                        SizedBox(
                          height: 15.0.h,
                        ),
                        MyTextField(
                            hint: 'enter your password',
                            controller: cubit.passController,
                            validatorText: 'This field can not be empty',
                            icon: Icon(
                              Icons.password,
                              color: ColorManager.lightColor,
                            ),
                            onTap: () {}),
                        SizedBox(
                          height: 20.0.h,
                        ),
                        MainButton(
                            btnText: 'Sign Up',
                            press: () async {
                              try {
                                if (cubit.formKeySign.currentState!
                                    .validate()) {
                                  userCredential = await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: cubit.emailController.text,
                                          password: cubit.passController.text);
                                  debugPrint('$userCredential');
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
                                                'The password provided is too weak.',
                                                style: TextStyle(
                                                    color:
                                                        ColorManager.txtColor,
                                                    fontSize: 20.sp),
                                              ),
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
                                                'The account already exists for that email.',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                        ColorManager.txtColor,
                                                    fontSize: 20.sp),
                                              ),
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
                              'Already have an account? ',
                              style: TextStyle(color: ColorManager.lightColor),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()),
                                  );
                                },
                                child: Text(
                                  'Login',
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

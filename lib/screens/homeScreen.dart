import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes_app/components/mainButton.dart';
import 'package:notes_app/components/noteCard.dart';
import 'package:notes_app/cubit/appCubit.dart';
import 'package:notes_app/cubit/appStates.dart';
import 'package:notes_app/presentation/colorManager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/screens/signUp.dart';
import '../cubit/appStates.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit()..getUserData(),
        child: BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = AppCubit.get(context);
              return Scaffold(
                appBar: AppBar(
                  systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent),
                  title: const Text(
                    'Notes App',
                    style: TextStyle(color: Colors.black),
                  ),
                  centerTitle: true,
                  elevation: 0,
                  iconTheme: IconThemeData(color: Colors.black),
                  backgroundColor: ColorManager.lightColor,
                ),
                drawer: Drawer(
                  backgroundColor: ColorManager.lightColor,
                  child: ListView(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: ColorManager.lightColor,
                                child: Image.asset(
                                  'assets/images/profile.png',
                                  height: 100.h,
                                  width: 100.w,
                                ),
                                radius: 35.0.r,
                              ),
                              SizedBox(
                                width: 16.0.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Welcome Back ! ',
                                    style: TextStyle(fontSize: 20.sp),
                                  ),
                                  SizedBox(
                                    height: 8.0.h,
                                  ),
                                  Text(
                                    '${cubit.user!.email}',
                                    style: TextStyle(fontSize: 14.sp),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        color: ColorManager.disabledColor,
                        height: 1.0.h,
                        thickness: 1.0.r,
                      ),
                      ListTile(
                        title: Text('Language'),
                        onTap: () {
                          // Update the state of the app.
                          // ...
                        },
                      ),
                      Divider(
                        color: ColorManager.disabledColor,
                        height: 1.0.h,
                        thickness: 1.0.r,
                      ),
                      ListTile(
                        title: Text('Dark Mode'),
                        onTap: () {
                          // Update the state of the app.
                          // ...
                        },
                      ),
                      Divider(
                        color: ColorManager.disabledColor,
                        height: 1.0.h,
                        thickness: 1.0.r,
                      ),
                      ListTile(
                        title: Text('LogOut'),
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                      ),
                      Divider(
                        color: ColorManager.disabledColor,
                        height: 1.0.h,
                        thickness: 1.0.r,
                      ),
                    ],
                  ),
                ),
                backgroundColor: ColorManager.lightColor,
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.0.h,
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('flutterNotes')
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator(
                              color: Colors.red,
                            ));
                          }
                          if (snapshot.hasData) {
                            debugPrint('it is here');
                            return SizedBox(
                              height: 800.h,
                              width: 400.w,
                              child: GridView(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                children: snapshot.data!.docs
                                    .map((note) => noteCard(() {}, note))
                                    .toList(),
                              ),
                            );
                          }
                          return Center(
                            child: Text(
                              'There is no Notes',
                              style: TextStyle(
                                  color: ColorManager.txtColor,
                                  fontSize: 20.0.sp),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                // floatingActionButton: FloatingActionButton.extended(
                //   onPressed: () {},
                //   label: Text(
                //     'Add Note',
                //     style: TextStyle(color: ColorManager.lightColor),
                //   ),
                //   backgroundColor: ColorManager.primaryColor,
                // ),
                bottomSheet: Material(
                  shadowColor: Colors.black,
                  elevation: 10,
                  child: Container(
                    height: 120.h,
                    decoration: BoxDecoration(
                        color: ColorManager.txtColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40).r,
                            topRight: Radius.circular(40.0.r))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MainButton(
                            btnText: 'Add Note',
                            press: () {},
                            height: 60.h,
                            width: 200.w),
                        // IconButton(
                        //     color: Colors.white,
                        //     onPressed: () {},
                        //     icon: Icon(
                        //       Icons.search,
                        //       color: Colors.black,
                        //     ))
                        SizedBox(
                          width: 14.0.w,
                        ),
                        FloatingActionButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          backgroundColor: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}

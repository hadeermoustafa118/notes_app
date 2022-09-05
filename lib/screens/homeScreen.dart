import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes_app/components/mainButton.dart';
import 'package:notes_app/cubit/appCubit.dart';
import 'package:notes_app/cubit/appStates.dart';
import 'package:notes_app/presentation/colorManager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/screens/addNote.dart';
import 'package:notes_app/screens/editNote.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/screens/noteDetails.dart';
import 'package:notes_app/screens/searchScreen.dart';
import '../main.dart';
import 'login.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit()..getData(),
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
                  iconTheme: const IconThemeData(color: Colors.black),
                  backgroundColor: ColorManager.lightColor,
                ),
                drawer: Drawer(
                  backgroundColor: ColorManager.lightColor,
                  child: ListView(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        decoration:const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: ColorManager.lightColor,
                              radius: 35.0.r,
                              child:  Image.asset(
                                'assets/images/profile.png',
                                height: 100.h,
                                width: 100.w,
                              ),
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
                                // Text(
                                //   '${cubit.user!.email}',
                                //   style: TextStyle(fontSize: 14.sp),
                                // ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: ColorManager.disabledColor,
                        height: 1.0.h,
                        thickness: 1.0.r,
                      ),
                      ListTile(
                        title: const Text('Language'),
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
                        title: const Text('Dark Mode'),
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
                        title: const Text('LogOut'),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20.0)
                            .r,
                        child: Container(
                          height: 800.h,
                          width: 400.w,
                          child: FutureBuilder(
                            future: notesRef
                                .where("user_id",
                                    isEqualTo:
                                        FirebaseAuth.instance.currentUser!.uid)
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  itemCount: cubit.notes.length,
                                  itemBuilder: (context, index) {
                                    return Dismissible(
                                      onDismissed: (direction) async{
                                        notesRef.doc(snapshot.data!.docs[index].id).delete();
                                      },key: UniqueKey(),
                                      child: InkWell(
                                        onTap: () {Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => NoteDetail(notes: cubit.notes[index] ,)),
                                        );},
                                        child: Container(
                                          padding: const EdgeInsets.all(16.0).r,
                                          margin: const EdgeInsets.all(12.0).r,
                                          decoration: BoxDecoration(
                                              color: ColorManager.cardColors[
                                                  cubit.notes[index]
                                                      ['color_id']],
                                              borderRadius:
                                                  BorderRadius.circular(20.0)
                                                      .r),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    cubit.notes[index]
                                                        ['note_title'],
                                                    style: TextStyle(
                                                        fontSize: 24.sp,
                                                        color: ColorManager
                                                            .txtColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    maxLines: 1,
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        debugPrint(
                                                            'from home ${snapshot.data!.docs[index].id}');
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      EditNote(index: index,
                                                                        docId: snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                            .id,
                                                                        noteList: cubit.notes,
                                                                      )),
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons
                                                            .edit_note_outlined,
                                                        size: 28.r,
                                                      ))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8.0.h,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    cubit.notes[index]
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
                                                    cubit.notes[index]
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
                                                cubit.notes[index]
                                                    ['note_content'],
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  color: ColorManager.txtColor,
                                                  fontWeight: FontWeight.w400,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }

                              return const Center(
                                  child: CircularProgressIndicator(
                                color: Colors.red,
                              ));
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
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
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AddNote()),
                              );
                            },
                            height: 60.h,
                            width: 200.w),

                        SizedBox(
                          width: 14.0.w,
                        ),
                        FloatingActionButton(
                          onPressed: () {Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SearchScreen()),
                          );},
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

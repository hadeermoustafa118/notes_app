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
import '../constant.dart';
import '../main.dart';
import 'login.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  title: Text(
                    'Notes App',
                    style: GoogleFonts.pacifico(
                        color: isDark
                            ? ColorManager.txtLight
                            : ColorManager.txtColor,
                        fontSize: 22.0.sp),
                  ),
                  centerTitle: true,
                  elevation: 0,
                  iconTheme: IconThemeData(
                      color: isDark ? Colors.white : Colors.black),
                  backgroundColor:
                      isDark ? ColorManager.dartColor : ColorManager.lightColor,
                ),
                drawer: Drawer(
                  backgroundColor:
                      isDark ? ColorManager.dartColor : ColorManager.lightColor,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        decoration: BoxDecoration(
                          color: isDark
                              ? ColorManager.dartColor
                              : ColorManager.lightColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: isDark
                                  ? ColorManager.dartColor
                                  : ColorManager.lightColor,
                              radius: 35.0.r,
                              child: Image.asset(
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
                                  'welcome',
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      color: isDark
                                          ? ColorManager.txtLight
                                          : ColorManager.txtColor),
                                ).tr(),
                                SizedBox(
                                  height: 8.0.h,
                                ),
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
                        title: Text(
                          'lang',
                          style: TextStyle(
                              color: isDark
                                  ? ColorManager.txtLight
                                  : ColorManager.txtColor),
                        ).tr(),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: isDark? ColorManager.dartColor:ColorManager.lightColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.r))),
                                  height: 200.h,
                                  width: 300.w,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'choose lang',
                                        style: TextStyle(
                                            color:isDark?  ColorManager.txtLight:ColorManager.txtColor,
                                            fontSize: 22.sp,
                                            decoration: TextDecoration.none),
                                      ).tr(),
                                      SizedBox(
                                        height: 50.0.h,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 25.0.w,
                                          ),
                                          MainButton(
                                              btnText: 'English',
                                              press: () {
                                                cubit.changeLanguageToEnglish(
                                                    context);
                                              },
                                              height: 50.h,
                                              width: 100.w),
                                          SizedBox(
                                            width: 50.0.w,
                                          ),
                                          MainButton(
                                              btnText: 'العربية',
                                              press: () {
                                                cubit.changeLanguageToArabic(
                                                    context);
                                              },
                                              height: 50.h,
                                              width: 100.w),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      Divider(
                        color: ColorManager.disabledColor,
                        height: 1.0.h,
                        thickness: 1.0.r,
                      ),
                      ListTile(
                        title: Text('Mode',
                                style: TextStyle(
                                    color: isDark
                                        ? ColorManager.txtLight
                                        : ColorManager.txtColor))
                            .tr(),
                        onTap: () {
                          cubit.changeModeApp();
                        },
                      ),
                      Divider(
                        color: ColorManager.disabledColor,
                        height: 1.0.h,
                        thickness: 1.0.r,
                      ),
                      ListTile(
                        title: Text('logout',
                                style: TextStyle(
                                    color: isDark
                                        ? ColorManager.txtLight
                                        : ColorManager.txtColor))
                            .tr(),
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
                backgroundColor:
                    isDark ? ColorManager.dartColor : ColorManager.lightColor,
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
                                      background: Container(
                                        padding: const EdgeInsets.all(16.0).r,
                                        margin: const EdgeInsets.all(12.0).r,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(20.0).r),
                                        child: Icon(
                                          Icons.delete_forever,
                                          color: isDark
                                              ? ColorManager.dartColor
                                              : ColorManager.lightColor,
                                        ),
                                      ),
                                      onDismissed: (direction) async {
                                        notesRef
                                            .doc(snapshot.data!.docs[index].id)
                                            .delete();
                                      },
                                      key: UniqueKey(),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    NoteDetail(
                                                      notes: cubit.notes[index],
                                                    )),
                                          );
                                        },
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
                                                                      EditNote(
                                                                        index:
                                                                            index,
                                                                        docId: snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                            .id,
                                                                        noteList:
                                                                            cubit.notes,
                                                                      )),
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons
                                                            .edit_note_outlined,color: ColorManager.dartColor,

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
                  elevation: 10,
                  child: Container(
                    color: isDark
                        ? ColorManager.dartColor
                        : ColorManager.lightColor,
                    child: Container(
                      height: 120.h,
                      decoration: BoxDecoration(
                          color: isDark
                              ? ColorManager.lightColor
                              : ColorManager.dartColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40).r,
                              topRight: Radius.circular(40.0.r))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MainButton(
                              btnText: 'add',
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SearchScreen()),
                              );
                            },
                            backgroundColor: isDark
                                ? ColorManager.dartColor
                                : ColorManager.lightColor,
                            child: Icon(
                              Icons.search,
                              color: isDark
                                  ? ColorManager.lightColor
                                  : ColorManager.dartColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}

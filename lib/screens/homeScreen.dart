import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes_app/components/mainButton.dart';
import 'package:notes_app/components/noteCard.dart';
import 'package:notes_app/presentation/colorManager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   systemOverlayStyle:
      //       const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      //   title: const Text(
      //     'Notes App',
      //     style: TextStyle(color: Colors.black),
      //   ),
      //   centerTitle: true,
      //   elevation: 0,
      //   backgroundColor: ColorManager.lightColor,
      //   actions: [
      //     IconButton(
      //       icon: Icon(
      //         Icons.search,
      //         color: Colors.black,
      //       ),
      //       onPressed: () {},
      //     ),
      //     SizedBox(
      //       width: 10.0.w,
      //     )
      //   ],
      // ),
      backgroundColor: ColorManager.lightColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('flutterNotes')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
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
                          color: ColorManager.txtColor, fontSize: 20.0.sp),
                    ),
                  );
                },
              ),
            ],
          ),
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
  }
}

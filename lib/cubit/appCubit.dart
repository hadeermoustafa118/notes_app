import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/presentation/colorManager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'appStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  //for sign up
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var usernameController = TextEditingController();
  var formKeySign = GlobalKey<FormState>();

//for login
  var emailForLoginController = TextEditingController();
  var passForLoginController = TextEditingController();
  var formKeyLogin = GlobalKey<FormState>();

  //for home screen
  String? userName;

// add user
  addUserData({required String username, required String mail}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .add({'email': mail, 'username': username});
    debugPrint('user added');
  }

  int? colorIndex;
  int? colorIndexEdit;
//add note

  addNote({
    required int colorId,
    required String noteContent,
    required String noteDate,
    required String noteTime,
    required String noteTitle,
    required String userId,
  }) async {
    await FirebaseFirestore.instance.collection('flutterNotes').add({
      'color_id': colorId,
      'note_content': noteContent,
      'note_date': noteDate,
      'note_time': noteTime,
      'note_title': noteTitle,
      'user_id': userId
    });
    debugPrint('note added');
  }

  //get note

  List notes = [];
  getData() async {
    emit(LoadingNotesState());
    CollectionReference notesRef =
        FirebaseFirestore.instance.collection('flutterNotes');
    await notesRef
        .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        notes.add(element.data());
        debugPrint('${element.data()}');
        debugPrint('${element.id}');
        emit(SuccessNotesState());
      });
    }).catchError((error) {
      emit(ErrorNotesState());
    });
  }

  //edit note

  editNote({
    required int colorId,
    required String noteContent,
    required String noteDate,
    required String noteTime,
    required String noteTitle,
    required String userId,
    required String docId,
  }) async {
    await FirebaseFirestore.instance
        .collection('flutterNotes')
        .doc(docId)
        .update(
      {
        'color_id': colorId,
        'note_content': noteContent,
        'note_date': noteDate,
        'note_time': noteTime,
        'note_title': noteTitle,
        'user_id': userId,
      },
    );

    debugPrint('note updated');
  }

  // add note form attributes

  List<Widget> circels = [
    CircleAvatar(
      backgroundColor: ColorManager.cardColors[0],
      radius: 35.r,
    ),
    CircleAvatar(
      backgroundColor: ColorManager.cardColors[1],
      radius: 35.r,
    ),
    CircleAvatar(
      backgroundColor: ColorManager.cardColors[2],
      radius: 35.r,
    ),
    CircleAvatar(
      backgroundColor: ColorManager.cardColors[3],
      radius: 35.r,
    ),
    CircleAvatar(
      backgroundColor: ColorManager.cardColors[4],
      radius: 35.r,
    ),
    CircleAvatar(
      backgroundColor: ColorManager.cardColors[5],
      radius: 35.r,
    ),
  ];
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  var formKeyNote = GlobalKey<FormState>();
  dynamic currentTime = DateFormat.jm().format(DateTime.now());
  dynamic currentDate = DateFormat.yMMMd().format(DateTime.now());

  var titleEditController = TextEditingController();
  var contentEditController = TextEditingController();
  var formKeyEditNote = GlobalKey<FormState>();
  dynamic currentTimeEdit = DateFormat.jm().format(DateTime.now());
  dynamic currentDateEdit = DateFormat.yMMMd().format(DateTime.now());

  // search

  List notesResult = [];
  var searchController = TextEditingController();

  searchByTitle() async {
    emit(LoadingSearchState());
    CollectionReference notesRef =
        FirebaseFirestore.instance.collection('flutterNotes');
    await notesRef
        .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)

        .get()
        .then((value) {
      value.docs.forEach((element) {
        notesResult.add(element.data());
        debugPrint('${element.data()}');
        debugPrint('${element.id}');
        emit(SuccessSearchState());
      });
    }).catchError((error) {
      emit(ErrorSearchState());
    });
  }

  String? title;
  String? content;
  int? color;
}

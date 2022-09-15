import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/presentation/colorManager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constant.dart';
import '../network/casheHelper.dart';
import 'appStates.dart';
import 'package:easy_localization/easy_localization.dart';

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

  // add note controllers
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  var formKeyNote = GlobalKey<FormState>();
  dynamic currentTime = DateFormat.jm().format(DateTime.now());
  dynamic currentDate = DateFormat.yMMMd().format(DateTime.now());

//edit controllers
  var titleEditController = TextEditingController();
  var contentEditController = TextEditingController();
  var formKeyEditNote = GlobalKey<FormState>();
  dynamic currentTimeEdit = DateFormat.jm().format(DateTime.now());
  dynamic currentDateEdit = DateFormat.yMMMd().format(DateTime.now());

  // search

  List notesResult = [];
  var searchController = TextEditingController();
  String? noteTitle;
  searchByTitle() async {
    emit(LoadingSearchState());
    CollectionReference notesRef =
        FirebaseFirestore.instance.collection('flutterNotes');
    await notesRef
        .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      notesResult = [];
      value.docs.forEach((element) {
        noteTitle = element.get('note_title');
        if (noteTitle!.contains(searchController.text)) {
          notesResult.add(element.data());
        }
        emit(SuccessSearchState());
      });
    }).catchError((error) {
      emit(ErrorSearchState());
    });
  }

  List<bool> taby = [false, false, false, false, false, false];
  String? title;
  String? content;
  bool tab = false;
  Widget widget = Container();
  void changeTabVale(index) {
    for (int i = 0; i < taby.length; i++) {
      taby[i] = false;
    }
    taby[index] = !taby[index];
    emit(ChangeTabVale());
  }

// switch mode
  void changeModeApp() {
    isDark = !isDark;
    CashHelper.saveData(key: 'isDark', value: isDark)
        .then((value) => {emit(ChangeModeState())});
  }
    //switch language

    void changeLanguageToArabic(BuildContext context){
      context.setLocale(Locale('ar'));
      emit(ArabicState());
    }
  void changeLanguageToEnglish(BuildContext context){
    context.setLocale(Locale('en'));
    emit(EnglishState());
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'appStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  var user ;
getUserData (){
  user = FirebaseAuth.instance.currentUser;
  debugPrint('${user!.email}');
}
}

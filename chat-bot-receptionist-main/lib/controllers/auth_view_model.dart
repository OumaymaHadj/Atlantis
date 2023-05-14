import 'dart:developer';

import 'package:chat_res/view/home.view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/login.view.dart';


class AuthViewModel extends GetxController{
  static AuthViewModel to = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String email = "", password = "", fullName = "";

  late Rx<User?> _user;

  User? get user => _user.value;

  @override
  void onInit() {
    super.onInit();
    _user = Rxn<User>(_auth.currentUser);
    _user.bindStream(_auth.userChanges());
  }

  @override
  void onReady() {
    ever(_user, initialScreen);
  }

  initialScreen(_user) {
    if (_user == null) {
      Get.offAll(() => LoginView());
    } else {
      Get.offAll(() => HomeView());
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  signInWithEmailAndPassword() async {
    try {
      log(email+" "+password);
      await _auth.signInWithEmailAndPassword(email: email, password: password).catchError((onError){
        log(onError);
      });
    } on FirebaseAuthException catch (error) {
      log(error.toString());
      Get.snackbar("Error Login Account", error.message!,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }


  void createAccountWithEmailAndPassword() async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;
      user?.updateDisplayName(fullName);

      Get.snackbar(
        'Success',
        "Created account",
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
    } on FirebaseAuthException catch (e) {
      log(email + " " + password);
      Get.snackbar(
        'Error register account',
        e.message!,
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }


  Future<void> signOut() {
    return _auth.signOut();
  }

}
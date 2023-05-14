import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_view_model.dart';
import '../widget/bottom.form.dart';
import '../widget/textform.dart';

class Register extends GetWidget<AuthViewModel> {
  Register({super.key});
  final AuthViewModel authViewController = Get.find<AuthViewModel>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: SafeArea(
              child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Image.asset("assets/Atlantis1.png", height: 200, width: 200,),
                ),
                const Text(
                  "Create your account",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 40),
                //Username input
                TextForm(
                  onSave: (value) {
                    authViewController.fullName = value!;
                  },
                  validator: (value) {
                    if (value == null) {
                      print('error');
                    }
                    return value!;
                  },
                  obscured: false,
                  text: 'Fullname',
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 20),
                //Email input
                TextForm(
                  onSave: (value) {
                    authViewController.email = value!;
                  },
                  validator: (value) {
                    if (value == null) {
                      print('error');
                    }
                    return value!;
                  },
                  obscured: false,
                  text: 'Email',
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                //password input
                TextForm(
                  onSave: (value) {
                    authViewController.password = value!;
                  },
                  validator: (value) {
                    if (value == null) {
                      print('error');
                    }
                    return value!;
                  },
                  obscured: true,
                  text: 'Password',
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 20),
                BottomForm(
                  onPress: ()  {
                    _formKey.currentState?.save();

                    controller.createAccountWithEmailAndPassword();
                  },
                  text: 'Sign Up',
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}

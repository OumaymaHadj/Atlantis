import 'package:chat_res/helper/main.color.dart';
import 'package:chat_res/view/register.view.dart';
import 'package:chat_res/widget/bottom.form.dart';
import 'package:chat_res/widget/textform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_view_model.dart';

class LoginView extends GetWidget<AuthViewModel> {
  LoginView({super.key});
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
                  "Login to your account",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 40),
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
                  onPress: () async {
                    _formKey.currentState?.save();

                    await controller.signInWithEmailAndPassword();
                  },
                  text: 'Sign In',
                ),
                const SizedBox(height: 20),
                Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account ?",
                        ),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                MainColor.mainColor),
                          ),
                          onPressed: () {
                            Get.to(() => Register());
                          },
                          child: const Text(' Sign Up'),
                        )
                      ],
                    )),
              ],
            ),
          )),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginRegisterController extends GetxController{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool? success;
  String? userEmail = '';

  void dispose(){

    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void register() async {
    final User? user = (await _auth.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ))
        .user;
    if (user != null) {
        success = true;
        print ('Registro OK');
        Future.delayed(
          Duration(seconds: 2),
          (){
            Get.toNamed("/foodpage");
          },
        );
    } else {
      success = false;
    }
  }
}
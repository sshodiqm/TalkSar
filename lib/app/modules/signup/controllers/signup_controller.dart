import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SignupController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController confirmPassC = TextEditingController();
  TextEditingController usernameC = TextEditingController();

  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();
    confirmPassC.dispose();
    usernameC.dispose();
    super.onClose();
  }
}

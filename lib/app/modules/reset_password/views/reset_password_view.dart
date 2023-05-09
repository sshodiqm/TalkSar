import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:talk_s_a_r/res/theme.dart';
import '../../../controllers/auth_controller.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  final authC = Get.find<AuthController>();
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Reset Password',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          minimum: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Form(
            child: ListView(
              children: [
                Image.asset(
                  'assets/img/resetpass.jpg',
                  width: 500,
                  height: 300,
                ),
                SizedBox(
                  height: 30,
                ),
                const Text(
                  "Masukkan Email Anda, kami akan mengirimkan link reset password melalui Email tersebut",
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5, top: 15),
                  child: Text(
                    "Email",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
                TextFormField(
                  controller: controller.emailC,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      labelText: "Email",
                      contentPadding: EdgeInsets.all(15)),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: blueSAR),
                  onPressed: () => authC.resetPassword(controller.emailC.text),
                  child: Text("RESET"),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Sudah punya akun?"),
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text(
                        "Login",
                        style: TextStyle(color: orangeSAR),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

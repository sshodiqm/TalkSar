import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:talk_s_a_r/app/controllers/auth_controller.dart';
import 'package:talk_s_a_r/app/routes/app_pages.dart';

import '../../../../res/theme.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _loginController = Get.find<LoginController>();
  final _authC = Get.find<AuthController>();

  static const TextStyle defaultText = TextStyle(
    color: Colors.black54,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  bool _secureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Masuk',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          minimum: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Form(
            child: ListView(
              children: [
                Image.asset('assets/img/logo.png'),
                SizedBox(
                  height: 30,
                ),

                //text judul
                const Text(
                  'Selamat Datang!',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //text deskripsi
                Container(
                  margin: EdgeInsets.only(bottom: 24),
                  child: const Text(
                    'Masukkan Email dan kata sandi Anda yang telah terdaftar',
                    textAlign: TextAlign.left,
                    style: defaultText,
                  ),
                ),

                //email
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Email',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                //input email
                TextFormField(
                  controller: _loginController.emailC,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      labelText: "Masukkan email Anda",
                      contentPadding: EdgeInsets.all(15)),
                ),

                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Kata Sandi',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                //input kata sandi
                Container(
                  child: TextFormField(
                    controller: _loginController.passC,
                    obscureText: _secureText,
                    decoration: InputDecoration(
                      labelText: "Masukkan kata sandi Anda",
                      contentPadding: EdgeInsets.all(16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _secureText ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _secureText = !_secureText;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Get.toNamed(Routes.RESET_PASSWORD),
                    child: Text(
                      "Reset Password",
                      style: TextStyle(color: orangeSAR),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: blueSAR),
                  onPressed: () => _authC.login(_loginController.emailC.text,
                      _loginController.passC.text),
                  child: Text("LOGIN"),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Belum punya akun?"),
                    TextButton(
                      onPressed: () => Get.toNamed(Routes.SIGNUP),
                      child: Text(
                        "Daftar Sekarang",
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

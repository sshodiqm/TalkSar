import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:talk_s_a_r/app/controllers/auth_controller.dart';
import 'package:talk_s_a_r/res/theme.dart';

import '../controllers/signup_controller.dart';

class SignupView extends StatefulWidget {
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _signupController = Get.find<SignupController>();
  final _authC = Get.find<AuthController>();

  var defaultText = TextStyle(
    color: Colors.black54,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );

  var boldText = TextStyle(
    color: Colors.black54,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  bool _secureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'SignupView',
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
                Image.asset('assets/img/logo.png'),
                SizedBox(
                  height: 30,
                ),
                const Text(
                  "Selamat Datang!",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        style: defaultText,
                        text:
                            'Silahkan daftarkan diri Anda dan menjadi bagian dari ',
                      ),
                      TextSpan(
                        text: 'TalkSar',
                        style: boldText,
                      ),
                    ]),
                  ),
                ),

                //Username
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Username",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
                //input username
                TextFormField(
                  controller: _signupController.usernameC,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: "Username",
                    contentPadding: EdgeInsets.all(15),
                  ),
                ),
                //Email
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Email",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
                //input email
                TextFormField(
                  controller: _signupController.emailC,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: "Email",
                    contentPadding: EdgeInsets.all(15),
                  ),
                ),
                //kata sandi
                Container(
                  margin: const EdgeInsets.only(bottom: 5, top: 15),
                  child: Text(
                    "Kata Sandi",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
                //input kata sandi
                TextFormField(
                  controller: _signupController.passC,
                  obscureText: _secureText,
                  decoration: InputDecoration(
                      labelText: "Masukkan kata sandi Anda",
                      contentPadding: EdgeInsets.all(16),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _secureText ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _secureText = !_secureText;
                          });
                        },
                      )),
                ),

                //konfirmasi password
                Container(
                  margin: const EdgeInsets.only(bottom: 5, top: 15),
                  child: Text(
                    'Konfirmasi Kata Sandi',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),

                //Input konfirmasi kata sandi
                TextFormField(
                  controller: _signupController.confirmPassC,
                  decoration: InputDecoration(
                      labelText: "Masukkan kembali kata sandi Anda",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Konfirmasi kata sandi tidak boleh kosong';
                    } else if (value != _signupController.passC.text) {
                      return 'Konfirmasi kata sandi tidak cocok';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blueSAR,
                  ),
                  onPressed: () => _authC.signup(
                    _signupController.emailC.text,
                    _signupController.passC.text,
                    _signupController.confirmPassC.text,
                    _signupController.usernameC.text,
                  ),
                  child: Text("DAFTAR"),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Sudah punya akun?"),
                    TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          "Masuk Sekarang",
                          style: TextStyle(color: orangeSAR),
                        ))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

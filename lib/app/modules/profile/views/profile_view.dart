import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:talk_s_a_r/app/controllers/auth_controller.dart';
import 'package:talk_s_a_r/app/routes/app_pages.dart';
import 'package:talk_s_a_r/res/theme.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final _formKey = GlobalKey<FormState>();
  final authC = Get.find<AuthController>();

  static const TextStyle defaultText = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );

  static const TextStyle boldText = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil Pengguna',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/img/logo.png',
              width: 70,
            ),
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Image.asset(
                'assets/img/user_profile.jpg',
                width: 500,
                height: 300,
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Username :',
                        style: boldText,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          controller.username,
                          style: defaultText,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Email',
                        style: boldText,
                      ),
                      const SizedBox(width: 41),
                      const Text(
                        ':',
                        style: boldText,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          controller.email,
                          style: defaultText,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Password',
                        style: boldText,
                      ),
                      const SizedBox(width: 7),
                      const Text(
                        ':',
                        style: boldText,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          controller.password,
                          style: defaultText,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: blueSAR),
                      onPressed: () => Get.toNamed(Routes.RESET_PASSWORD),
                      child: Text(
                        "RESET PASSWORD",
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: orangeSAR),
                    onPressed: () => authC.logout(),
                    child: Text("KELUAR"),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

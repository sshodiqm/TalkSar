// import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:talk_s_a_r/app/controllers/auth_controller.dart';
import 'package:talk_s_a_r/app/modules/profile/controllers/profile_controller.dart';

import 'app/routes/app_pages.dart';
import 'app/utils/loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(AuthController(), permanent: true);
  final profileC = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: authC.streamAuthStatus,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            print(snapshot.data);
            return GetMaterialApp(
              title: "Application",
              initialRoute:
                  snapshot.data != null && snapshot.data!.emailVerified == true
                      ? Routes.MAIN_SCREEN
                      : Routes.LOGIN,
              getPages: AppPages.routes,
            );
          }
          return LoadingView();
        },
    );
  }
}

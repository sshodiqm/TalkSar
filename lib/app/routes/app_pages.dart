import 'package:get/get.dart';

import 'package:talk_s_a_r/app/modules/add_kritik/bindings/add_kritik_binding.dart';
import 'package:talk_s_a_r/app/modules/add_kritik/views/add_kritik_view.dart';
import 'package:talk_s_a_r/app/modules/edit_kritik/bindings/edit_kritik_binding.dart';
import 'package:talk_s_a_r/app/modules/edit_kritik/views/edit_kritik_view.dart';
import 'package:talk_s_a_r/app/modules/history/bindings/history_binding.dart';
import 'package:talk_s_a_r/app/modules/history/views/history_view.dart';
import 'package:talk_s_a_r/app/modules/home/bindings/home_binding.dart';
import 'package:talk_s_a_r/app/modules/home/views/home_view.dart';
import 'package:talk_s_a_r/app/modules/login/bindings/login_binding.dart';
import 'package:talk_s_a_r/app/modules/login/views/login_view.dart';
import 'package:talk_s_a_r/app/modules/main_screen/bindings/main_screen_binding.dart';
import 'package:talk_s_a_r/app/modules/main_screen/views/main_screen_view.dart';
import 'package:talk_s_a_r/app/modules/profile/bindings/profile_binding.dart';
import 'package:talk_s_a_r/app/modules/profile/views/profile_view.dart';
import 'package:talk_s_a_r/app/modules/reset_password/bindings/reset_password_binding.dart';
import 'package:talk_s_a_r/app/modules/reset_password/views/reset_password_view.dart';
import 'package:talk_s_a_r/app/modules/signup/bindings/signup_binding.dart';
import 'package:talk_s_a_r/app/modules/signup/views/signup_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.ADD_KRITIK,
      page: () => AddKritikView(),
      binding: AddKritikBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_KRITIK,
      page: () => EditKritikView(),
      binding: EditKritikBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_SCREEN,
      page: () => MainScreenView(),
      binding: MainScreenBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}

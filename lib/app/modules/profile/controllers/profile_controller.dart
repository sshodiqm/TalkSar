import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:talk_s_a_r/app/controllers/auth_controller.dart';

class ProfileController extends GetxController {
  late final FirebaseAuth auth = Get.find<AuthController>().auth;

  final count = 0.obs;
  final isEditingUsername = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  void startEditingUsername() {
    isEditingUsername.value = true; // ubah niali variabel isEditingUsername menjadi true
  }

  void updateUsername(String newUsername) {
    isEditingUsername.value = false;
  }
}

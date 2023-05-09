import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:talk_s_a_r/app/controllers/auth_controller.dart';

class ProfileController extends GetxController {
  late final FirebaseAuth auth = Get.find<AuthController>().auth;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final count = 0.obs;
  String username = "";
  String email = "";
  String password = "";

  @override
  void onInit() async {
    super.onInit();
    final user = auth.currentUser;
    if (user != null) {
      final emailQuery = await firestore
          .collection("users")
          .where("email", isEqualTo: user.email)
          .get();
      if (emailQuery.docs.isNotEmpty) {
        final userData = emailQuery.docs.first.data();
        username = userData["username"];
        email = userData["email"];
        password = userData["password"];
        update();
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}

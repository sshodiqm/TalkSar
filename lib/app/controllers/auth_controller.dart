import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:talk_s_a_r/app/routes/app_pages.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  void resetPassword(String email) async {
    if (email != "" && GetUtils.isEmail(email)) {
      try {
        await auth.sendPasswordResetEmail(email: email);
        Get.defaultDialog(
          title: "Berhasil",
          middleText: "Kami telah mengirimkan reset password ke email $email.",
          onConfirm: () {
            Get.back(); // Close dialoh
            Get.back(); // Move to login
          },
          textConfirm: "Ya, Saya mengerti",
        );
      } catch (e) {
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Tidak dapat mengirimkan reset password.",
        );
      }
    } else {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Email tidak valid",
      );
    }
  }

  void login(String email, String password) async {
    try {
      UserCredential myUser = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (myUser.user!.emailVerified) {
        Get.offAllNamed(Routes.MAIN_SCREEN);
      } else {
        Get.defaultDialog(
          title: "Email Verification",
          middleText:
              "Kamu perlu verifikasi email terlebih dahulu. Butuh verifikasi ulang?",
          onConfirm: () async {
            await myUser.user!.sendEmailVerification();
            Get.back();
          },
          textConfirm: "Kirim Ulang",
          textCancel: "Kembali",
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: 'No user found for that email.',
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: 'Wrong password provided for that user.',
        );
      }
    } catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: 'Tidak dapat login dengan akun ini.',
      );
    }
  }

  void signup(String email, String password, String confirm, String username) async {
    if (password != confirm) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: 'Konfirmasi Password tidak cocok.',
      );
      return;
    }
    try {
      UserCredential myUser =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await myUser.user!.updateDisplayName(username);
      await myUser.user!.sendEmailVerification();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(myUser.user!.uid)
          .set({
        'username': username,
        'email': email,
        'password': password,
      });
      Get.defaultDialog(
        title: "Email Verification",
        middleText: "Kami telah mengirimkan email verifikasi ke $email.",
        onConfirm: () {
          Get.back(); // close dialog
          Get.back(); // go to login
        },
        textConfirm: "Ya, Saya akan cek email.",
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: 'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: 'The account already exists for that email.',
        );
      }
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: 'Tidak dapat mendaftarkan akun ini',
      );
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}

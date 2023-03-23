import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditKritikController extends GetxController {
  late TextEditingController judulC;
  late TextEditingController kategoriC;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Object?>> getData(String docID) async {
    DocumentReference docRef = firestore.collection("kritik").doc(docID);
    return docRef.get();
  }

  void editKritik(String judul, String kategori, String docID) async {
    DocumentReference docData = firestore.collection("kritik").doc(docID);

    try {
      await docData.update({
        "judul": judul,
        "kategori": kategori,
      });

      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil mengubah kritik",
        onConfirm: () {
          judulC.clear();
          kategoriC.clear();
          Get.back(); //close dialog
          Get.back(); //back to home
        },
        textConfirm: "OKAY",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Tidak berhasil mengubah kritik!",
      );
    }
  }

  @override
  void onInit() {
    judulC = TextEditingController();
    kategoriC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    judulC.dispose();
    kategoriC.dispose();
    super.onClose();
  }
}

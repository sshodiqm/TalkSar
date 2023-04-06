import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditKritikController extends GetxController {
  late TextEditingController judulC;
  late TextEditingController kategoriC;
  late TextEditingController deskripsiC;
  List<String> kategoriList = [
    'Dosen',
    'Pegawai',
    'Fasilitas',
    'Pelayanan',
  ];

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Object?>> getData(String docID) async {
    DocumentReference docRef = firestore.collection("kritik").doc(docID);
    return docRef.get();
  }

  void editKritik(
    String judul,
    String kategori,
    String deskripsi,
    File image,
    String docID,
  ) async {
    final storage = FirebaseStorage.instance;
    DocumentReference docData = firestore.collection("kritik").doc(docID);

    try {
      // update data ke penyimpanan firebase
      final ref = storage.ref().child('kritik/${DateTime.now().toString()}');
      final task = ref.putFile(image);
      final snapshot = await task.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      await docData.update({
        "judul": judul,
        "kategori": kategori,
        "deskripsi": deskripsi,
        "gambar": downloadUrl,
      });

      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil mengubah kritik",
        onConfirm: () {
          judulC.clear();
          kategoriC.clear();
          deskripsiC.clear();
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
    deskripsiC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    judulC.dispose();
    kategoriC.dispose();
    deskripsiC.dispose();
    super.onClose();
  }
}

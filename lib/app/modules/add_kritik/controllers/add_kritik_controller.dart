import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddKritikController extends GetxController {
  late TextEditingController judulC;
  late TextEditingController kategoriC;
  late TextEditingController deskripsiC;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addKritik(
    String judul,
    String kategori,
    String deskripsi,
    File image,
    String userId,
  ) async {
    // Inisialisasi Firebase
    await Firebase.initializeApp();
    final storage = FirebaseStorage.instance;

    CollectionReference kritik = firestore.collection("kritik");

    try {
      // Unggah gambar ke penyimpanan Firebase
      final ref = storage.ref().child('kritik/${DateTime.now().toString()}');
      final task = ref.putFile(image);
      final snapshot = await task.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      String dateNow = DateTime.now().toIso8601String();

      // Simpan data ke Firestore
      await kritik.add({
        "judul": judul,
        "kategori": kategori,
        "deskripsi": deskripsi,
        "gambar": downloadUrl,
        "createdAt": dateNow,
        "userId": userId,
      });

      // Tampilkan dialog konfirmasi
      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil menambahkan kritik",
        onConfirm: () {
          judulC.clear();
          kategoriC.clear();
          deskripsiC.clear();
          // gambarC.clear();
          Get.back(); //close dialog
          Get.back(); //back to home
        },
        textConfirm: "OKAY",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Gagal menambahkan kritik!",
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

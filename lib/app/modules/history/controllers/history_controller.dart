import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Object?>> getData() async {
    CollectionReference kritik = firestore.collection("kritik");

    return kritik.get();
  }

  Stream<QuerySnapshot<Object?>> streamData(
      {bool isDescending = true,
      bool Function(DocumentSnapshot<Object?> doc)? filter}) {
    final user = FirebaseAuth.instance.currentUser;
    CollectionReference kritik = firestore.collection("kritik");
    Query query = kritik.where('userId', isEqualTo: user?.uid);
    query = query.orderBy("createdAt", descending: isDescending);
    return query.snapshots();
  }

  // Stream<QuerySnapshot<Object?>> streamData(
  //     {bool isDescending = true,
  //     bool Function(DocumentSnapshot<Object?> doc)? filter}) {
  //   final user = FirebaseAuth.instance.currentUser;
  //   CollectionReference kritik = firestore.collection("kritik");
  //   Query query = kritik.where('userId', isEqualTo: user?.uid);
  //   if (isDescending) {
  //     query = query.orderBy("createdAt", descending: true);
  //   } else {
  //     query = query.orderBy("createdAt", descending: false);
  //   }
  //   return query.snapshots();
  // }

  void deleteKritik(String docId) {
    DocumentReference docRef = firestore.collection("kritik").doc(docId);
    try {
      Get.defaultDialog(
        title: "Hapus Kritik",
        middleText: "Apakah kamu yakin menghapus kritik ini?.",
        onConfirm: () async {
          await docRef.delete();
          Get.back();
        },
        textConfirm: "YES",
        textCancel: "NO",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi kesalahan",
        middleText: "Tidak berhasil menghapus data ini.",
      );
    }
  }
}

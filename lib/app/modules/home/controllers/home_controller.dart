import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

// import '../../../data/Kritik.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Object?>> getData() async {
    CollectionReference kritik = firestore.collection("kritik");

    return kritik.orderBy('createdAt', descending: true).get();
  }

  Stream<QuerySnapshot<Object?>> streamData({bool isDescending = true}) {
    CollectionReference kritik = firestore.collection("kritik");
    if (isDescending) {
      return kritik.orderBy('createdAt', descending: true).snapshots();
    } else {
      return kritik.orderBy('createdAt', descending: false).snapshots();
    }
  }

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

  // Future<bool> toggleLike(Kritik kritik) async {
  //   DocumentReference docRef = firestore.collection('kritik').doc(kritik.id);
  //   try {
  //     await docRef.update({'isLiked': !kritik.isLiked});
  //     return true;
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }
}

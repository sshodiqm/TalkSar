import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/modules/history/controllers/history_controller.dart';
import '../app/routes/app_pages.dart';

class ListKritikRiwayat extends StatelessWidget {
  const ListKritikRiwayat({
    super.key,
    required this.listAllDocs,
    required this.controller,
  });

  final List<QueryDocumentSnapshot<Object?>> listAllDocs;
  final HistoryController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listAllDocs.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () => Get.toNamed(
          Routes.EDIT_KRITIK,
          arguments: {
            "docID": listAllDocs[index].id,
            "gambar":
                (listAllDocs[index].data() as Map<String, dynamic>)["gambar"],
          },
        ),
        leading: Image.network(
          "${(listAllDocs[index].data() as Map<String, dynamic>)["gambar"]}",
          width: 50,
        ),
        title: Text(
          "${(listAllDocs[index].data() as Map<String, dynamic>)["judul"]}",
        ),
        subtitle: Text(
          "Kategori : ${(listAllDocs[index].data() as Map<String, dynamic>)["kategori"]}",
        ),
        trailing: IconButton(
          onPressed: () => controller.deleteKritik(listAllDocs[index].id),
          icon: Icon(Icons.delete),
        ),
      ),
    );
  }
}

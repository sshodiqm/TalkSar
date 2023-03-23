import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListKritik extends StatelessWidget {
  const ListKritik({
    super.key,
    required this.listAllDocs,
  });

  final List<QueryDocumentSnapshot<Object?>> listAllDocs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listAllDocs.length,
      itemBuilder: (context, index) => ListTile(
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
      ),
    );
  }
}

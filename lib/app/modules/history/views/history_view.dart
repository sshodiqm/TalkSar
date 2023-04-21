import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talk_s_a_r/app/controllers/auth_controller.dart';
import '../../../../widget/list_kritik_riwayat.dart';
import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    Get.put(HistoryController());
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Riwayat',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () => authC.logout(),
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.streamData(isDescending: true),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var listAllDocs = snapshot.data!.docs;
            return ListKritikRiwayat(
                listAllDocs: listAllDocs, controller: controller);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

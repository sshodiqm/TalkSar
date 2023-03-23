import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talk_s_a_r/app/controllers/auth_controller.dart';
import '../../../../widget/list_kritik_riwayat.dart';
import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  final authC = Get.find<AuthController>();

  List<Tab> myTab = [
    Tab(
      text: "Terbaru",
    ),
    Tab(
      text: "Terlama",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(HistoryController());
    return MaterialApp(
      home: DefaultTabController(
        length: myTab.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text('HISTORY'),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () => authC.logout(),
                icon: Icon(Icons.logout),
              )
            ],
            bottom: TabBar(
              tabs: myTab,
            ),
          ),

          // FOR REALTIME GET DATA FROM DB
          body: TabBarView(
            children: [
              StreamBuilder<QuerySnapshot<Object?>>(
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
              StreamBuilder<QuerySnapshot<Object?>>(
                stream: controller.streamData(isDescending: false),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    var listAllDocs = snapshot.data!.docs;
                    return ListKritikRiwayat(
                        listAllDocs: listAllDocs, controller: controller);
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

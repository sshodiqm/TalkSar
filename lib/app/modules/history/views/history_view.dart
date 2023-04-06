import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talk_s_a_r/app/controllers/auth_controller.dart';
import '../../../../res/theme.dart';
import '../../../../widget/list_kritik_riwayat.dart';
import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  final authC = Get.find<AuthController>();
  final List<Tab> myTab = [
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
            bottom: TabBar(
              labelColor: greenSAR,
              unselectedLabelColor: greySAR,
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: greenSAR,
                  ),
                ),
              ),
              tabs: myTab,
            ),
          ),
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
                    // var listAllDocs = snapshot.data?.docs ?? [];
                    var listAllDocs = snapshot.data!.docs;
                    return ListKritikRiwayat(
                        listAllDocs: listAllDocs, controller: controller);
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
              // StreamBuilder<QuerySnapshot<Object?>>(
              //   stream: controller.streamData(isDescending: false),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.active &&
              //         snapshot.data != null) {
              //       var listAllDocs = snapshot.data!.docs;
              //       return ListKritikRiwayat(
              //           listAllDocs: listAllDocs, controller: controller);
              //     }
              //     return Center(child: CircularProgressIndicator());
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

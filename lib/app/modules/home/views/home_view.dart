import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talk_s_a_r/app/controllers/auth_controller.dart';
import 'package:talk_s_a_r/app/routes/app_pages.dart';
import '../../../../widget/list_kritik.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();

  List<Tab> myTab = [
    Tab(
      text: "Terbaru",
    ),
    Tab(
      text: "Terlama",
    ),
    Tab(
      text: "Populer",
    )
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return MaterialApp(
      home: DefaultTabController(
        length: myTab.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text('HOME'),
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
                    return ListKritik(listAllDocs: listAllDocs);
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
              StreamBuilder<QuerySnapshot<Object?>>(
                stream: controller.streamData(isDescending: false),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    var listAllDocs = snapshot.data!.docs;
                    return ListKritik(listAllDocs: listAllDocs);
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
              Center(
                child: Text("Populer"),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Get.toNamed(Routes.ADD_KRITIK),
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

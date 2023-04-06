import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talk_s_a_r/app/controllers/auth_controller.dart';
import 'package:talk_s_a_r/app/routes/app_pages.dart';
import 'package:talk_s_a_r/res/theme.dart';
import '../../../../widget/list_kritik.dart';
import '../controllers/home_controller.dart';

// stateful & home view versi 1
class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final authC = Get.find<AuthController>();

  final List<Tab> myTab = [
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

  // kategori yang tersedia
  final List<String> categories = [
    "Semua",
    "Dosen",
    "Pegawai",
    "Fasilitas",
    "Pelayanan",
  ];

  // variabel untuk menyimpan kategori yang dipilih
  String selectedCategory = "Semua";

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return MaterialApp(
      home: DefaultTabController(
        length: myTab.length,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            title: Image.asset(
              'assets/img/logo.png',
              width: 100,
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

          // FOR REALTIME GET DATA FROM DB
          body: Column(
            children: [
              // Row kategori
              Container(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (categories[index] == "Semua") {
                            selectedCategory = "Semua";
                          } else {
                            selectedCategory = categories[index];
                          }
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: selectedCategory == categories[index]
                              ? Colors.white
                              : greyBackground,
                          border: Border.all(
                            color: selectedCategory == categories[index]
                                ? greenSAR
                                : greyBorder,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          categories[index],
                          style: selectedCategory == categories[index]
                              ? TextStyle(color: greenSAR)
                              : TextStyle(color: greyTextCategory),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    StreamBuilder<QuerySnapshot<Object?>>(
                      stream: Get.find<HomeController>().streamData(
                        isDescending: true,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          var listAllDocs = snapshot.data!.docs;
                          return ListKritik(
                            listAllDocs: listAllDocs,
                            category: selectedCategory,
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                    StreamBuilder<QuerySnapshot<Object?>>(
                      stream: Get.find<HomeController>().streamData(
                        isDescending: false,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          var listAllDocs = snapshot.data!.docs;
                          return ListKritik(
                            listAllDocs: listAllDocs,
                            category: selectedCategory,
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                    Center(
                      child: Text("Populer"),
                    )
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: greenSAR,
            onPressed: () => Get.toNamed(Routes.ADD_KRITIK),
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

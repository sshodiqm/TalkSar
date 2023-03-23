import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:talk_s_a_r/app/modules/history/views/history_view.dart';
import 'package:talk_s_a_r/app/modules/home/views/home_view.dart';
import 'package:talk_s_a_r/app/modules/profile/views/profile_view.dart';

import '../controllers/main_screen_controller.dart';

class MainScreenView extends StatefulWidget {
  @override
  _MainScreenViewState createState() => _MainScreenViewState();
}

class _MainScreenViewState extends State<MainScreenView> {
  final MainScreenController c = Get.put(MainScreenController());
  late int index;

  List showPage = [
    HomeView(),
    HistoryView(),
    ProfileView(),
  ];

  @override
  void initState() {
    index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showPage[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Riwayat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}

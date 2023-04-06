import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talk_s_a_r/res/theme.dart';
import '../controllers/add_kritik_controller.dart';

class AddKritikView extends StatefulWidget {
  @override
  _AddKritikViewState createState() => _AddKritikViewState();
}

class _AddKritikViewState extends State<AddKritikView> {
  final picker = ImagePicker();
  File? _image;
  final _judulController = TextEditingController();
  final _kategoriController = TextEditingController();
  final _deskripsiController = TextEditingController();
  String? _userId;

  List<String> _kategoriList = [
    'Dosen',
    'Pegawai',
    'Fasilitas',
    'Pelayanan',
  ];

  @override
  void initState() {
    super.initState();
    _kategoriController.text =
        _kategoriList[0]; // Atur nilai awal untuk _kategoriController.text
    _getUserID();
  }

  Future<void> _getUserID() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userId = user.uid;
      });
    }
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _addKritik() async {
    if (_judulController.text.isEmpty ||
        _kategoriController.text.isEmpty ||
        _deskripsiController.text.isEmpty ||
        _image == null ||
        _userId == null) {
      Get.snackbar(
        "Terjadi Kesalahan",
        "Pastikan semua field terisi dan gambar sudah dipilih",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final controller = Get.put(AddKritikController());

    try {
      controller.addKritik(
        _judulController.text,
        _kategoriController.text,
        _deskripsiController.text,
        _image!,
        _userId!,
      );
    } catch (e) {
      Get.snackbar(
        "Terjadi Kesalahan",
        "Gagal menambahkan kritik!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Tulis Kritik',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Card(
              child: InkWell(
                onTap: _getImageFromGallery,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  child: _image != null
                      ? Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        )
                      : Center(
                          child: Text("Tambahkan gambar"),
                        ),
                ),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _judulController,
              autocorrect: false,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: "Judul",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            DropdownButtonFormField<String>(
              value: _kategoriController.text,
              onChanged: (value) {
                setState(() {
                  _kategoriController.text = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Kategori',
              ),
              items: _kategoriList
                  .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  })
                  .toList()
                  .toList(),
            ),
            TextField(
              controller: _deskripsiController,
              maxLines: 5,
              maxLength: 500,
              decoration: InputDecoration(
                labelText: "Deskripsi Kritik",
                hintText: "Tulis deskripsi kritik Anda di sini",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _addKritik,
              child: Text("ADD KRITIK"),
              style: ElevatedButton.styleFrom(backgroundColor: blueSAR),
            )
          ],
        ),
      ),
    );
  }
}

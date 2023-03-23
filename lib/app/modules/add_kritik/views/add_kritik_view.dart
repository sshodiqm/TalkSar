import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
        _image == null) {
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
        _image!,
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
        title: Text('ADD KRITIK'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
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
            TextField(
              controller: _kategoriController,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: "Kategori",
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _addKritik,
              child: Text("ADD KRITIK"),
            )
          ],
        ),
      ),
    );
  }
}

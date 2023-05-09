import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talk_s_a_r/res/theme.dart';

import '../controllers/edit_kritik_controller.dart';

class EditKritikView extends StatefulWidget {
  @override
  _EditKritikViewState createState() => _EditKritikViewState();
}

class _EditKritikViewState extends State<EditKritikView> {
  final picker = ImagePicker();
  File? _image;

  Future<void> _getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditKritikController());
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Edit Kritik',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot<Object?>>(
        future: controller.getData(Get.arguments),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            controller.judulC.text = data["judul"];
            controller.kategoriC.text = data["kategori"];
            controller.deskripsiC.text = data["deskripsi"];
            var gambarUrl = data["gambar"];
            return Padding(
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
                            : Image.network(
                                gambarUrl,
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                        // Center(
                        //     child: Text(
                        //       "Ganti gambar",
                        //       style: TextStyle(fontWeight: FontWeight.bold),
                        //     ),
                        //   ),
                      ),
                    ),
                  ),
                  TextField(
                    controller: controller.judulC,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "Judul",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField(
                    value: controller.kategoriC.text,
                    items: controller.kategoriList.map((String kategori) {
                      return DropdownMenuItem<String>(
                        value: kategori,
                        child: Text(kategori),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      controller.kategoriC.text = value!;
                    },
                    decoration: InputDecoration(
                      labelText: "Kategori",
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: controller.deskripsiC,
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
                    onPressed: () {
                      // cek jika _image tidak null sebelum digunakan
                      if (_image != null) {
                        controller.editKritik(
                          controller.judulC.text,
                          controller.kategoriC.text,
                          controller.deskripsiC.text,
                          _image!,
                          Get.arguments,
                        );
                      } else {
                        controller.editKritik(
                          controller.judulC.text,
                          controller.kategoriC.text,
                          controller.deskripsiC.text,
                          null,
                          Get.arguments,
                        );
                      }
                    },
                    child: Text("EDIT KRITIK"),
                    style: ElevatedButton.styleFrom(backgroundColor: blueSAR),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/edit_kritik_controller.dart';

class EditKritikView extends StatefulWidget {
  @override
  _EditKritikViewState createState() => _EditKritikViewState();
}

class _EditKritikViewState extends State<EditKritikView> {
  final controller = Get.put(EditKritikController());
  final picker = ImagePicker();
  File? _image;

  @override
  void initState() {
    super.initState();
    var args = Get.arguments;
    if (args != null) {
      setState(() {
        _image = File(args["gambar"]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EDIT KRITIK'),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot<Object?>>(
        future: controller.getData(Get.arguments),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            controller.judulC.text = data["judul"];
            controller.kategoriC.text = data["kategori"];
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Card(
                    child: InkWell(
                      onTap: initState,
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
                  TextField(
                    controller: controller.kategoriC,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: "Kategori",
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => controller.editKritik(
                      controller.judulC.text,
                      controller.kategoriC.text,
                      Get.arguments,
                    ),
                    child: Text("EDIT KRITIK"),
                  ),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

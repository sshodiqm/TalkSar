import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProfileView'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[200],
              backgroundImage: AssetImage('assets/images/default_profile.png'),
            ),
            SizedBox(height: 20,),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Username',
                suffixIcon: Obx(() => controller.isEditingUsername.value ? IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () => controller.updateUsername(_usernameController.text),
                ) : SizedBox.shrink()),
              ),
              onTap: () {
                // panggil method startEditingUsername() pada controller ketika field Username ditekan
                controller.startEditingUsername();
              },
              controller: _usernameController,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              initialValue: controller.auth.currentUser?.email ?? '',
              readOnly: true,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              initialValue: '********',
              readOnly: true,
            ),
          ],
        ),
      ),
    );
  }
}

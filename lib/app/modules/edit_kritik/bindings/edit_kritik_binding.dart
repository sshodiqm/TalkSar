import 'package:get/get.dart';

import '../controllers/edit_kritik_controller.dart';

class EditKritikBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditKritikController>(
      () => EditKritikController(),
    );
  }
}

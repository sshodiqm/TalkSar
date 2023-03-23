import 'package:get/get.dart';

import '../controllers/add_kritik_controller.dart';

class AddKritikBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddKritikController>(
      () => AddKritikController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/regist_controller.dart';

class RegistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistController>(
      () => RegistController(),
    );
  }
}

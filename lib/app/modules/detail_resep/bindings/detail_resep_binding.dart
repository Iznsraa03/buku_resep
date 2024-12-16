import 'package:get/get.dart';

import '../controllers/detail_resep_controller.dart';

class DetailResepBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailResepController>(
      () => DetailResepController(),
    );
  }
}

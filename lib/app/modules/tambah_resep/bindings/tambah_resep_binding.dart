import 'package:get/get.dart';

import '../controllers/tambah_resep_controller.dart';

class TambahResepBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahResepController>(
      () => TambahResepController(),
    );
  }
}

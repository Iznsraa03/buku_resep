import 'package:get/get.dart';

import '../controllers/form_tambah_resep_controller.dart';

class FormTambahResepBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormTambahResepController>(
      () => FormTambahResepController(),
    );
  }
}

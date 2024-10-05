import 'package:get/get.dart';

class DashboardController extends GetxController {
  var currentIndex = 0.obs;

  // Fungsi untuk mengubah index saat icon di navbar ditekan
  void changePage(int index) {
    currentIndex.value = index;
  }
}

import 'package:get/get.dart';

class CategoryController extends GetxController {
  //TODO: Implement CategoryController
  final RxBool isFavorited = false.obs;
  
  void toggleFavorite() {
    isFavorited.value = !isFavorited.value; // Toggle status favorit
  }
}

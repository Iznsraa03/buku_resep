import 'package:get/get.dart';

class CategoryController extends GetxController {
  final RxBool isFavorited = false.obs;
  
  void toggleFavorite() {
    isFavorited.value = !isFavorited.value; // Toggle status favorit
  }

  var categories = [
    {'title': 'Masakan Asia', 'description': 'Lihat Deskripsi', 'image': 'assets/img/rendang.png'},
    {'title': 'Masakan Eropa', 'description': 'Lihat Deskripsi', 'image': 'assets/img/spaghetti.png'},
    {'title': 'Masakan Indonesia', 'description': 'Lihat Deskripsi', 'image': 'assets/img/nasi_goreng.png'},
  ].obs;

  // Pencarian kategori
  var searchText = ''.obs;

  // Filter kategori berdasarkan pencarian
  List<Map<String, String>> get filteredCategories {
    return categories.where((category) {
      return category['title']!.toLowerCase().contains(searchText.value.toLowerCase());
    }).toList();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var resepList = <Map<String, dynamic>>[].obs;
  var filteredList = <Map<String, dynamic>>[].obs;
  var searchQuery = ''.obs;
  var kategoriTerpilih = ''.obs; 

  // Method untuk mengambil data dari koleksi 'resep'
  Future<void> fetchResep() async {
    try {
      // Mengambil data dari koleksi 'resep'
      final QuerySnapshot snapshot = await _firestore.collection('resep').get();

      // Memetakan data ke dalam list
      resepList.value = snapshot.docs.map((doc) {
        return {
          "docId":doc.id,
          "bahan": doc['bahan'],
          "img": doc['img'],
          "nama": doc['nama'],
          "upload_by": doc['upload_by'],
        };
      }).toList();

      // Saat data diambil, tampilkan semua data di filteredList
      filteredList.assignAll(resepList);
    } catch (e) {
      // Menangani error
      print("Error fetching resep: $e");
    }
  }

  // Method untuk memfilter list berdasarkan nama
  void filterListByName(String query) {
    if (query.isEmpty) {
      // Jika query kosong, tampilkan semua data
      filteredList.assignAll(resepList);
    } else {
      // Filter data berdasarkan nama
      filteredList.assignAll(
        resepList
            .where((resep) => resep['nama']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList(),
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchResep(); // Memanggil method fetchResep saat controller diinisialisasi

    // Dengarkan perubahan pada searchQuery dan filter data
    searchQuery.listen((query) {
      filterListByName(query);
    });
  }
  
  void setKategori(String kategori) {
    kategoriTerpilih.value = kategori;
    filterResepByCategory(kategori);
  }

  // Fungsi untuk memfilter resep berdasarkan kategori
  void filterResepByCategory(String kategori) {
    // Logika untuk mengambil resep sesuai kategori
    // Gantilah dengan logika sesuai dengan cara pengambilan data di aplikasi Anda
    filteredList.value = resepList
        .where((resep) => resep['daerah'] == kategori)
        .toList();
  }
}

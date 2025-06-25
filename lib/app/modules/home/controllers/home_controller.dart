import 'package:buku_resep/utils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var resepList = <Map<String, dynamic>>[].obs;
  var filteredList = <Map<String, dynamic>>[].obs;
  var searchQuery = ''.obs;
  var kategoriTerpilih = ''.obs;
  var isLiked = false.obs;
  var isBookmarked = false.obs;

  void toggleLike() {
    isLiked.value = !isLiked.value;
  }
  void toggleBookmark(){
    isBookmarked.value = !isBookmarked.value;
  }

  Future<void> fetchResep() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('resep').get();
      resepList.value = snapshot.docs.map((doc) {
        return {
          "docId":doc.id,
          "bahan": doc['bahan'],
          "img": doc['img'],
          "nama": doc['nama'],
          "upload_by": doc['upload_by'],
        };
      }).toList();
      filteredList.assignAll(resepList);
    } catch (e) {
      print("Error fetching resep: $e");
    }
  }

  void filterListByName(String query) {
    if (query.isEmpty) {
      filteredList.assignAll(resepList);
    } else {
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

  void showBottomSheet(BuildContext context, Map<String, dynamic> resep) {
    Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Bagikan Resep',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(20),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Bagikan ke Media Sosial'),
              onTap: () {
                Navigator.pop(context); // Tutup Bottom Sheet
                Share.share(
                  'Cek resep ${resep['nama']} ini! 🌟\n\n${resep['img']}\n\nDibuat oleh: ${resep['upload_by']}\n\nBahan: ${resep['bahan']}',
                  subject: 'Resep Populer',
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('Salin Tautan'),
              onTap: () {
                Clipboard.setData(
                  ClipboardData(
                    text:
                        'Cek resep ${resep['nama']} ini! 🌟\n\n${resep['img']}\n\nDibuat oleh: ${resep['upload_by']}\n\nBahan: ${resep['bahan']}',
                  ),
                );
                Navigator.pop(context); // Tutup Bottom Sheet
                Get.snackbar(
                  'Berhasil',
                  'Tautan berhasil disalin ke clipboard!',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('Batal'),
              onTap: () {
                Navigator.pop(context); // Tutup Bottom Sheet
              },
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    );
  }
}

import 'package:buku_resep/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:share/share.dart';

import '../../../../widget/menu_card.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    // Inisialisasi HomeController
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              searchBar(),
              const Gap(20),
              const Text(
                'Resep Populer',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Gap(20),
              kategoryScroll(),
              const Gap(20),
              // ListView untuk menampilkan data resep
              Expanded(
                child: Obx(() {
                  // Jika tidak ada data yang ditemukan
                  if (controller.filteredList.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Dua kolom per baris
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: 0.8, // Rasio aspek untuk card
                    ),
                    itemCount: controller.filteredList.length,
                    itemBuilder: (context, index) {
                      final resep = controller.filteredList[index];
                      return contentCard(
                        img: resep['img'],
                        title: resep['nama'],
                        onTap: () {
                          Get.toNamed(
                            Routes.DETAIL_RESEP,
                            arguments: {
                              'docId':resep['docId'],
                              'nama': resep['nama'],
                              'img': resep['img'],
                              'upload_by': resep['upload_by'],
                              'bahan': resep['bahan'],
                            },
                          );
                        },
                        onLongPress: () {
                          _showBottomSheet(context, resep);
                        },
                      );
                    },
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, Map<String, dynamic> resep) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Padding(
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
        );
      },
    );
  }

  SingleChildScrollView kategoryScroll() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              controller.setKategori('Papua'); // Set kategori ke Papua
              Get.toNamed(Routes.CATEGORY); // Navigasi ke halaman kategori
            },
            child: Container(
              height: 45,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[300],
              ),
              child: const Center(
                  child: Text(
                'Papua',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ),
          ),
          const Gap(20),
          GestureDetector(
            onTap: () {
              controller.setKategori('Toraja'); // Set kategori ke Toraja
              Get.toNamed(Routes.CATEGORY); // Navigasi ke halaman kategori
            },
            child: Container(
              height: 45,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[300],
              ),
              child: const Center(
                  child: Text(
                'Toraja',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ),
          ),
          const Gap(20),
          GestureDetector(
            onTap: () {
              controller.setKategori('Manado'); // Set kategori ke Manado
              Get.toNamed(Routes.CATEGORY); // Navigasi ke halaman kategori
            },
            child: Container(
              height: 45,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[300],
              ),
              child: const Center(
                  child: Text(
                'Manado',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ),
          ),
          const Gap(20),
          GestureDetector(
            onTap: () {
              controller.setKategori('Bali'); // Set kategori ke Bali
              Get.toNamed(Routes.CATEGORY); // Navigasi ke halaman kategori
            },
            child: Container(
              height: 45,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[300],
              ),
              child: const Center(
                  child: Text(
                'Bali',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ),
          ),
          const Gap(20),
          GestureDetector(
            onTap: () {
              controller.setKategori('Jawa'); // Set kategori ke Jawa
              Get.toNamed(Routes.CATEGORY); // Navigasi ke halaman kategori
            },
            child: Container(
              height: 45,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[300],
              ),
              child: const Center(
                  child: Text(
                'Jawa',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ),
          ),
        ],
      ),
    );
  }

  TextField searchBar() {
    return TextField(
      cursorColor: Colors.black,
      onChanged: (value) {
        controller.searchQuery.value = value; // Perbarui query pencarian
      },
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: 'Cari resep',
        hintStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(30),
        ),
        suffixIcon: const Icon(Icons.search_outlined),
      ),
    );
  }
}

import 'package:buku_resep/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/tambah_resep_controller.dart';

class TambahResepView extends GetView<TambahResepController> {
  const TambahResepView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => TambahResepController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Resep Makanan \nAnda!',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                const Gap(20),
                Obx(() {
                  if (controller.resepList.isEmpty) {
                    return const Center(
                      child: Text(
                        'Data resep Anda kosong',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  } else {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: controller.resepList.length,
                      itemBuilder: (context, index) {
                        final resep = controller.resepList[index];
                        return contentCard(
                          img: resep['img'] ?? 'assets/img/default.png',
                          title: resep['nama'] ?? 'Tidak ada nama',
                          onTap: () {
                            // Navigasi atau logika tambahan bisa dimasukkan di sini
                          },
                          onEdit: () {},
                          onDelete: () {
                            Navigator.of(context).pop();
                            controller.deleteResep(resep['id']);
                          },
                        );
                      },
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.FORM_TAMBAH_RESEP);
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.orange,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }

  GestureDetector contentCard(
      {required String img,
      required String title,
      void Function()? onTap,
      required void Function()? onEdit,
      required void Function()? onDelete}) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: () {
        Get.defaultDialog(
          title: 'Pilihan Aksi',
          middleText: 'Pilih aksi yang ingin Anda lakukan',
          actions: [
            TextButton(
              onPressed: onEdit,
              child: const Text('Edit'),
            ),
            TextButton(
              onPressed: onDelete,
              child: const Text('Hapus'),
            ),
          ],
        );
      },
      child: SizedBox(
        width: 190,
        child: Card(
          elevation: 8,
          color: Colors.grey[300],
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(img, scale: 0.1,
                    errorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/img/default.png', scale: 0.1);
                }),
                const Gap(15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const Gap(10),
                        const Row(
                          children: [
                            ImageIcon(AssetImage('assets/icons/Desc.png'),
                                size: 20),
                            Gap(5),
                            Text('Lihat Resep')
                          ],
                        )
                      ],
                    ),
                    const Gap(20),
                    const Column(
                      children: [
                        Icon(Icons.favorite_border_outlined),
                        Gap(5),
                        Icon(Icons.bookmark_border_outlined)
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

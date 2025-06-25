import 'package:buku_resep/app/routes/app_pages.dart';
import 'package:buku_resep/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
      backgroundColor: AppColors.background,
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
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          columnCount: 2,
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: contentCard(
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
                              ),
                            ),
                          ),
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
        backgroundColor: AppColors.primary,
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
          backgroundColor: AppColors.background,
          buttonColor: AppColors.primary,
          title: 'Pilihan Aksi',
          middleText: 'Pilih aksi yang ingin Anda lakukan',
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primary
              ),
              onPressed: onEdit,
              child:  Text('Edit',style: TextStyle(color: Colors.white),),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primary
              ),
              onPressed: onDelete,
              child:  Text('Hapus', style: TextStyle(color: Colors.white),),
            ),
          ],
        );
      },
      child: SizedBox(
        width: 190,
        child: Card(
          elevation: 8,
          color: AppColors.primary,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(12),
                  child: Image.network(img, scale: 0.1,
                      errorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/img/default.png', scale: 0.1);
                  },
                  width: 500,),
                ),
                const Gap(10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                              color: Colors.white
                            ),
                          ),
                        ),
                      ]
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

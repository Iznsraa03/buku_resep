import 'package:buku_resep/app/routes/app_pages.dart';
import 'package:buku_resep/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';

import '../../../../widget/menu_card.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: AppColors.background,
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
              Expanded(
                child: Obx(() {
                  // if (controller.filteredList.isEmpty) {
                  //   return const Center(
                  //     child: CircularProgressIndicator(
                  //       color: AppColors.primary,
                  //     ),
                  //   );
                  // }
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: 0.8,
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
                              'docId': resep['docId'],
                              'nama': resep['nama'],
                              'img': resep['img'],
                              'upload_by': resep['upload_by'],
                              'bahan': resep['bahan'],
                            },
                          );
                        },
                        onLongPress: () =>
                            controller.showBottomSheet(context, resep),
                        index: index,
                        iconLike: Icon(
                          controller.isLiked.value
                              ? Icons.favorite_border_outlined
                              : Icons.favorite,
                          color: Colors.white,
                        ),
                        iconBM: Icon(
                          controller.isBookmarked.value
                              ? Icons.bookmark_border_outlined
                              : Icons.bookmark,
                          color: Colors.white,
                        ),
                        onPressedLike: controller.toggleLike,
                        onPressedBookmark: controller.toggleBookmark,
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

  SingleChildScrollView kategoryScroll() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 500),
          childAnimationBuilder: (widget) => SlideAnimation(
            horizontalOffset: 50.0,
            child: FadeInAnimation(
              child: widget,
            ),
          ),
          children: [
            GestureDetector(
              onTap: () {
                controller.setKategori('Papua');
                Get.toNamed(Routes.CATEGORY);
              },
              child: Container(
                height: 45,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.secondary,
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
                controller.setKategori('Toraja');
                Get.toNamed(Routes.CATEGORY);
              },
              child: Container(
                height: 45,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.secondary,
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
                controller.setKategori('Manado');
                Get.toNamed(Routes.CATEGORY);
              },
              child: Container(
                height: 45,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.secondary,
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
                controller.setKategori('Bali');
                Get.toNamed(Routes.CATEGORY);
              },
              child: Container(
                height: 45,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.secondary,
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
                controller.setKategori('Jawa');
                Get.toNamed(Routes.CATEGORY);
              },
              child: Container(
                height: 45,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.secondary,
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
      ),
    );
  }

  TextField searchBar() {
    return TextField(
      cursorColor: Colors.black,
      onChanged: (value) {
        controller.searchQuery.value = value;
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
          borderRadius: BorderRadius.circular(20),
        ),
        suffixIcon: const Icon(Icons.search_outlined),
      ),
    );
  }
}

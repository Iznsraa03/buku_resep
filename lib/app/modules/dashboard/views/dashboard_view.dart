
import 'package:buku_resep/app/modules/home/views/home_view.dart';
import 'package:buku_resep/app/modules/profile/views/profile_view.dart';
import 'package:buku_resep/app/modules/tambah_resep/views/tambah_resep_view.dart';
import 'package:buku_resep/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (controller.currentIndex.value) {
          case 0:
            return const HomeView();
          case 1:
            return const TambahResepView();
          case 2:
            return ProfileView();
          default:
            return const HomeView();
        }
      }),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        elevation: 5,
        backgroundColor: AppColors.background,
            currentIndex: controller.currentIndex.value,
            onTap: (index) {
              controller.changePage(index); 
            },
            selectedItemColor: AppColors.primary,
            selectedFontSize: 14,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: AppColors.primary,),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add, color: AppColors.primary,),
                label: 'Tambah Resep',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, color: AppColors.primary,),
                label: 'Profile',
              ),
            ],
          )),
    );
  }
}

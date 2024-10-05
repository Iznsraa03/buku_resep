import 'package:buku_resep/app/modules/category/views/category_view.dart';
import 'package:buku_resep/app/modules/home/views/home_view.dart';
import 'package:buku_resep/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // Menampilkan halaman sesuai index yang dipilih
        switch (controller.currentIndex.value) {
          case 0:
            return const HomeView();
          case 1:
            return const CategoryView();
          case 2:
            return const ProfileView();
          default:
            return const HomeView();
        }
      }),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: (index) {
              controller.changePage(index); // Ganti halaman sesuai index
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          )),
    );
  }
}

import 'package:buku_resep/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: true,
        title: const Text('Profile'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: Text('Edit Profile', style: GoogleFonts.poppins()),
              onTap: () {
                // Aksi untuk navigasi ke halaman Edit Profile
                Get.toNamed('/edit-profile');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: Text('Tentang Aplikasi', style: GoogleFonts.poppins()),
              onTap: () {
                // Aksi untuk navigasi ke halaman Tentang Aplikasi
                Get.toNamed('/about');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text('Logout', style: GoogleFonts.poppins()),
              onTap: () {
                // Aksi untuk logout
                Get.offAllNamed('/login');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(30),
            fotoProfil(),
            const Gap(30),
            field(
              title: controller.userData['username'] ?? 'Nama tidak ditemukan',
            ),
            const Gap(30),
            field(
              title: controller.userData['email'] ?? 'Email tidak ditemukan',
            ),
          ],
        ),
      ),
    );
  }

  CircleAvatar fotoProfil() {
    return CircleAvatar(
      radius: 80,
      backgroundImage: controller.userData['photoUrl'] != null
          ? NetworkImage(controller.userData['photoUrl'])
          : const AssetImage('assets/img/Group.png') as ImageProvider,
    );
  }

  Container field({required String title}) {
    return Container(
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 2.0),
      ),
      child: Center(
        child: Text(
          title,
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
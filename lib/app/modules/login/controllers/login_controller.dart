import 'package:buku_resep/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Obx untuk menyembunyikan atau menampilkan password
  var isPasswordHidden = true.obs;

  // Fungsi untuk toggle visibilitas password
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // Fungsi login
  void login() {
    Get.offAllNamed(Routes.DASHBOARD);
    Get.snackbar("LOGIN", "Selamat Datang Di Buku Resep Apps",snackPosition: SnackPosition.BOTTOM);
  }

  // Fungsi untuk login dengan Google
  void loginWithGoogle() {
    //Snackbar message untuk pesan action
    Get.snackbar('Info', 'Login dengan Google belum diimplementasi',
        snackPosition: SnackPosition.BOTTOM);
  }

  @override
  void onClose() {
    // Pastikan untuk dispose controller saat tidak diperlukan
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
  //fungsi untuk menuju ke halaman regist
  void regist(){
    Get.toNamed(Routes.REGIST);
    Get.snackbar("Create Account", 'Silahkan Membuat Akun',snackPosition: SnackPosition.BOTTOM);
  }
}
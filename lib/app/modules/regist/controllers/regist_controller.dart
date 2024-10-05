import 'package:buku_resep/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistController extends GetxController {
  // TextField Controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Obx untuk menyembunyikan atau menampilkan password
  final RxBool isPasswordHidden = true.obs;
  final RxBool isConfirmPasswordHidden = true.obs;

  // Function to toggle password visibility
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  // Function untuk validasi input
  String? validateInput() {
    if (usernameController.text.isEmpty) {
      return 'Username tidak boleh kosong';
    } else if (emailController.text.isEmpty || !emailController.text.contains('@')) {
      return 'Email tidak valid';
    } else if (passwordController.text.isEmpty) {
      return 'Password tidak boleh kosong';
    } else if (passwordController.text != confirmPasswordController.text) {
      return 'Password tidak sama';
    }
    return null;
  }

  // Function to handle Sign Up process
  void handleSignUp() {
    String? validationResult = validateInput();
    if (validationResult != null) {
      // Show error message
      Get.snackbar('Error', validationResult,
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
    } else {
      // Lakukan proses pendaftaran (bisa integrasi ke API, dll.)
      Get.offAllNamed(Routes.LOGIN);
      Get.snackbar('Success', 'Pendaftaran berhasil',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}

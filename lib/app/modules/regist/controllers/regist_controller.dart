import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class RegistController extends GetxController {
  // TextField Controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Obx untuk menyembunyikan atau menampilkan password
  final RxBool isPasswordHidden = true.obs;
  final RxBool isConfirmPasswordHidden = true.obs;

  // Firebase instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  // Function to handle Sign Up process with Firebase
  Future<void> handleSignUp() async {
    String? validationResult = validateInput();
    if (validationResult != null) {
      // Show error message
      Get.snackbar('Error', validationResult,
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
    } else {
      try {
        // Create user with Firebase Authentication
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // Save user data to Firestore
        await _firestore.collection('users').doc(userCredential.user?.uid).set({
          'username': usernameController.text,
          'email': emailController.text,
          'uid': userCredential.user?.uid,
        });

        // Show success message
        Get.offAllNamed(Routes.LOGIN);
        Get.snackbar('Success', 'Pendaftaran berhasil',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);

      } on FirebaseAuthException catch (e) {
        // Handle Firebase Auth error
        Get.snackbar('Error', e.message ?? 'Pendaftaran gagal',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      }
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
import 'package:buku_resep/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var isPasswordHidden = true.obs;

  // Firebase Auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(); // Instance GoogleSignIn

  // Fungsi untuk sembunyikan password
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // Validasi email dan password
  String? validateEmail(String email) {
    if (!GetUtils.isEmail(email)) {
      return 'Email tidak valid';
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.length < 6) {
      return 'Password minimal 6 karakter';
    }
    return null;
  }

  // Fungsi login
  Future<void> login() async {
    final email = usernameController.text;
    final password = passwordController.text;

    // Validasi input
    final emailError = validateEmail(email);
    final passwordError = validatePassword(password);

    if (emailError != null) {
      Get.snackbar("Error", emailError, snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (passwordError != null) {
      Get.snackbar("Error", passwordError, snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      // Login menggunakan Firebase Authentication
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar("LOGIN", "Selamat Datang ${userCredential.user?.email}",
          snackPosition: SnackPosition.BOTTOM);
      // Navigasi ke halaman utama atau dashboard setelah login sukses
      Get.offAllNamed(Routes.DASHBOARD);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "Login gagal",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Fungsi untuk login dengan Google
  Future<void> loginWithGoogle() async {
    try {
      // Trigger the Google Authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        Get.snackbar('Info', 'Login dengan Google dibatalkan',
            snackPosition: SnackPosition.BOTTOM);
        return; // Pengguna membatalkan login
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      UserCredential userCredential = await _auth.signInWithCredential(credential);

      Get.snackbar("LOGIN", "Selamat Datang ${userCredential.user?.displayName}",
          snackPosition: SnackPosition.BOTTOM);
      // Navigasi ke halaman utama atau dashboard setelah login sukses
      Get.offAllNamed(Routes.DASHBOARD);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "Login gagal",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Fungsi untuk menuju ke halaman regist
  void regist() {
    Get.toNamed(Routes.REGIST);
    Get.snackbar("Create Account", 'Silahkan Membuat Akun',
        snackPosition: SnackPosition.BOTTOM);
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
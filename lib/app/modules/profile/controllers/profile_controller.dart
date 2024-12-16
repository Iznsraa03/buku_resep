import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // Map untuk menyimpan data pengguna
  var userData = {}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentUserData();
  }

  void fetchCurrentUserData() async {
    try {
      // Ambil data user yang sedang login
      User? currentUser = auth.currentUser;
      if (currentUser == null) {
        print('Tidak ada pengguna yang sedang login.');
        return;
      }

      final userId = currentUser.uid;
      print('Mengambil data untuk userId: $userId');

      // Ambil dokumen pengguna dari Firestore
      final userDoc = await firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        // Simpan data pengguna ke dalam GetX
        userData.value = userDoc.data()!;
        print('Data pengguna berhasil diambil: ${userData.value}');
      } else {
        print('Data pengguna tidak ditemukan di Firestore untuk userId: $userId');
      }
    } catch (e) {
      print('Terjadi kesalahan saat mengambil data pengguna: $e');
    }
  }
}
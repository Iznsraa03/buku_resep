import 'package:buku_resep/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FormTambahResepController extends GetxController {
  var selectedImage = Rx<File?>(null);
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  Future<String?> getUsername(String uid) async {
    try {
      DocumentSnapshot userDoc = await firestore.collection('users').doc(uid).get();
      return userDoc['username'] as String?;
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil username: $e');
      return null;
    }
  }

  Future<void> saveRecipe(String namaResep, String deskripsi, String resep, String daerah) async {
    if (selectedImage.value == null) {
      Get.snackbar('Error', 'Silahkan pilih gambar terlebih dahulu');
      return;
    }

    try {
      // Dapatkan UID pengguna yang sedang login
      User? user = auth.currentUser;
      if (user == null) {
        Get.snackbar('Error', 'Pengguna belum login');
        return;
      }

      // Ambil username berdasarkan UID
      String? username = await getUsername(user.uid);
      if (username == null) {
        Get.snackbar('Error', 'Username tidak ditemukan');
        return;
      }

      // Upload gambar ke Firebase Storage
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final Reference ref = storage.ref().child('img/$fileName.jpg');
      await ref.putFile(selectedImage.value!);
      String imageUrl = await ref.getDownloadURL();

      // Simpan data ke Firestore
      await firestore.collection('resep').add({
        'nama': namaResep,
        'daerah' : daerah,
        'about': deskripsi,
        'bahan': resep,
        'img': imageUrl,
        'upload_by': username, 
        'createdAt': FieldValue.serverTimestamp(),
        
      });
      Get.offAllNamed(Routes.DASHBOARD);

      // Berhasil disimpan
      Get.snackbar('Success', 'Resep berhasil ditambahkan');
    } catch (e) {
      Get.snackbar('Error', 'Gagal menyimpan data: $e');
    }
  }
}
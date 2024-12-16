import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class TambahResepController extends GetxController {
  final resepList = <Map<String, dynamic>>[].obs;
  String? userNickname;

  @override
  void onInit() {
    super.onInit();
    fetchUserNickname();
  }

  // Ambil nickname dari pengguna yang sedang login
  void fetchUserNickname() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userSnapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      userNickname = userSnapshot.data()?['username'];
      fetchResep(); // Panggil fetchResep setelah mendapatkan nickname
    }
  }

  // Ambil data resep yang sesuai dengan nickname pengguna yang login
  void fetchResep() async {
    if (userNickname != null) {
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection('resep')
            .where('upload_by', isEqualTo: userNickname)
            .get();
        resepList.value = snapshot.docs.map((doc) {
          var data = doc.data();
          data['id'] = doc.id; // Tambahkan ID dokumen untuk referensi
          return data;
        }).toList();
      } catch (e) {
        print("Error fetching data: $e");
      }
    }
  }

  // Fungsi untuk menambahkan resep baru ke Firestore
  Future<void> addResep(Map<String, dynamic> newResep) async {
    try {
      newResep['upload_by'] = userNickname; // Tambahkan upload_by sesuai user yang login
      await FirebaseFirestore.instance.collection('resep').add(newResep);
      fetchResep(); // Refresh data resep setelah menambah
    } catch (e) {
      print("Error adding recipe: $e");
    }
  }

  // Fungsi untuk mengedit resep yang ada di Firestore
  Future<void> editResep(String docId, Map<String, dynamic> updatedResep) async {
    try {
      await FirebaseFirestore.instance.collection('resep').doc(docId).update(updatedResep);
      fetchResep(); // Refresh data resep setelah mengedit
    } catch (e) {
      print("Error updating recipe: $e");
    }
  }

  // Fungsi untuk menghapus resep dari Firestore
  Future<void> deleteResep(String docId) async {
    try {
      await FirebaseFirestore.instance.collection('resep').doc(docId).delete();
      fetchResep(); // Refresh data resep setelah menghapus
    } catch (e) {
      print("Error deleting recipe: $e");
    }
  }
}
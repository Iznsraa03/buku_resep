import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DetailResepController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList komentarList = <Map<String, dynamic>>[].obs;  // Menyimpan daftar komentar
  RxBool isLoading = true.obs;  // Status loading

  // Fungsi untuk mengambil data resep berdasarkan docId
  Future<void> getResep(String docId) async {
    try {
      isLoading.value = true;
      DocumentSnapshot snapshot = await _firestore.collection('resep').doc(docId).get();
      if (snapshot.exists) {
        // Lakukan sesuatu dengan data resep jika perlu
      }
    } catch (e) {
      print('Error fetching resep data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Fungsi untuk mengirim komentar ke Firestore
  Future<void> sendKomentar(String docId, String komentar) async {
    try {
      var user = FirebaseAuth.instance.currentUser;

      if (user != null && docId.isNotEmpty && komentar.isNotEmpty) {
        // Mengambil nama pengguna dari displayName atau fallback ke email
        String userName = user.displayName ?? user.email?.split('@')[0] ?? 'Anonim';

        // Menambahkan komentar ke koleksi 'komentar' di dalam dokumen resep
        await _firestore.collection('resep').doc(docId).collection('komentar').add({
          'komentar': komentar,
          'userName': userName,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Setelah komentar terkirim, refresh daftar komentar
        getKomentar(docId);
      }
    } catch (e) {
      print('Error sending komentar: $e');
    }
  }

  // Fungsi untuk mengambil daftar komentar berdasarkan docId
  Future<void> getKomentar(String docId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('resep')
          .doc(docId)
          .collection('komentar')
          .orderBy('timestamp', descending: true)
          .get();

      komentarList.clear();
      for (var doc in snapshot.docs) {
        komentarList.add(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print('Error fetching komentar: $e');
    }
  }
}
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/detail_resep_controller.dart';

class DetailResepView extends GetView<DetailResepController> {
  const DetailResepView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> resepData = Get.arguments ?? {};
    final String docId = resepData['docId'] ?? '';  // Ambil docId dari argument

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Resep ${resepData['nama'] ?? 'Tidak Tersedia'}',
          style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 25)),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                contentResep(
                  img: resepData['img'] ?? '',
                  title: resepData['nama'] ?? '',
                  writer: resepData['upload_by'] ?? 'Tidak Diketahui',
                  about: 'Papeda adalah salah satu makanan tradisional Papua...',
                  resep: '',
                ),
                const Gap(20),
                commentSection(docId), // Panggil commentSection dengan docId
                const Gap(20),
                // Menampilkan daftar komentar
                Obx(() {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.komentarList.length,
                    itemBuilder: (context, index) {
                      var komentar = controller.komentarList[index];
                      return ListTile(
                        title: Text(komentar['userName']),
                        subtitle: Text(komentar['komentar']),
                        trailing: Text(komentar['timestamp']?.toDate()?.toString() ?? ''),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Menambahkan komentar ke Firestore
  Row commentSection(String docId) {
    final TextEditingController commentController = TextEditingController();

    return Row(
      children: [
        const CircleAvatar(
          radius: 25,
          child: Icon(Icons.comment_outlined),
        ),
        const Gap(20),
        Expanded(
          child: TextField(
            controller: commentController,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(50),
              ),
              hintText: 'Komentar',
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            onSubmitted: (String komentar) {
              if (komentar.isNotEmpty) {
                controller.sendKomentar(docId, komentar); // Kirim komentar berdasarkan docId
                commentController.clear(); // Hapus isi input setelah dikirim
              }
            },
          ),
        ),
      ],
    );
  }

  Container contentResep({
    required String img,
    required String title,
    required String writer,
    required String resep,
    required String about,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          img.isNotEmpty
              ? Image.network(
                  img,
                  fit: BoxFit.fill,
                )
              : const Placeholder(
                  fallbackHeight: 150,
                  color: Colors.grey,
                ),
          const Gap(20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                const Gap(20),
                Text(
                  'Resep By : $writer',
                  style: GoogleFonts.poppins(),
                ),
                const Gap(20),
                Text(
                  about,
                  style: GoogleFonts.poppins(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
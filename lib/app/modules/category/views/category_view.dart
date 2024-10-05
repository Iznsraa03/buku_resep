import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              search(),
              Gap(20),
              Text('Carilah Kategori',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('Resep Masakan Yang Anda',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('Mau Masak!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Gap(20),
              content(title: 'Masakan Asia', description: 'Lihat Deskripsi'),
              content(title: 'Masakan Asia', description: 'Lihat Deskripsi'),
              content(title: 'Masakan Asia', description: 'Lihat Deskripsi'),
              content(title: 'Masakan Asia', description: 'Lihat Deskripsi'),
              content(title: 'Masakan Asia', description: 'Lihat Deskripsi'),
              content(title: 'Masakan Asia', description: 'Lihat Deskripsi'),
              content(title: 'Masakan Asia', description: 'Lihat Deskripsi'),
            ],
          ),
        ),
      ],
    ));
  }

  Container search() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(30)),
      child: TextField(
        cursorColor: Colors.black,
        decoration: InputDecoration(
            fillColor: Colors.grey,
            hintText: 'Cari',
            suffixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none),
            focusedBorder:
                const OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }

  Card content({required String title, required String description}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Kategori Masakan
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/img/rendang.png',
                width: 100,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            // Deskripsi dan Judul Kategori
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(20),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.description, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        description,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Ikon Favorite dan Bookmark
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.bookmark_border),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
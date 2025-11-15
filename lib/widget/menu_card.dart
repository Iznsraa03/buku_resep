import 'package:buku_resep/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

AnimationConfiguration contentCard({
  required String img,
  required String title,
  void Function()? onTap,
  void Function()? onLongPress,
  required int index,
  void Function()? onPressedLike,
  void Function()? onPressedBookmark,
  required Widget iconLike,
  required Widget iconBM,
}) {
  return AnimationConfiguration.staggeredList(
    position: index,
    duration: const Duration(milliseconds: 350),
    child: SlideAnimation(
      verticalOffset: 50.0,
      child: FadeInAnimation(
        child: GestureDetector(
          onTap: onTap,
          onLongPress: onLongPress,
          child: Card(
            elevation: 8,
            color: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              width: 160, // Lebar tetap untuk konsistensi
              height: 230, // Tinggi tetap untuk menghindari overflow
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bagian Gambar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        img,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 120,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/img/default.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 120,
                          );
                        },
                      ),
                    ),
                    const Gap(8),
                    
                    // Bagian Judul
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Gap(4),
                    
                    // Bagian "Lihat Resep"
                    const Row(
                      children: [
                        ImageIcon(
                          AssetImage('assets/icons/Desc.png'),
                          size: 16,
                          color: Colors.white,
                        ),
                        Gap(4),
                        Text(
                          'Lihat Resep',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Gap(8),
                    
                    // Bagian Tombol Like dan Bookmark
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Spacer untuk mendorong tombol ke kanan
                        const SizedBox.shrink(),
                        
                        Row(
                          children: [
                            IconButton(
                              onPressed: onPressedLike,
                              icon: iconLike,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              iconSize: 20,
                            ),
                            const Gap(4),
                            IconButton(
                              onPressed: onPressedBookmark,
                              icon: iconBM,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              iconSize: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
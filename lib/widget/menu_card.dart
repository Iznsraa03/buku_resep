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
  required Widget iconBM
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
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      img,
                      fit: BoxFit.cover,
                      width: 500,
                      height: 130,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/img/default.png',
                          fit: BoxFit.cover,
                          width: 500,
                          height: 150,
                        );
                      },
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Gap(10),
                          Text(
                            title,
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const Gap(35),
                          const Row(
                            children: [
                              ImageIcon(
                                AssetImage('assets/icons/Desc.png'),
                                size: 20,
                                color: Colors.white,
                              ),
                              Gap(5),
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
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                                onPressed: onPressedLike,
                                icon: iconLike
                              ),
                          Gap(5),
                          IconButton(
                                onPressed: onPressedBookmark,
                                icon: iconBM
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
  );
}

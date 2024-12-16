import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

GestureDetector contentCard(
      {required String img, required String title, void Function()? onTap, void Function()? onLongPress}) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Card(
            elevation: 8,
            color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(img),
                  const Gap(15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15))),
                          const Gap(10),
                          const Row(
                            children: [
                              ImageIcon(AssetImage('assets/icons/Desc.png'),
                                  size: 20),
                              Gap(5),
                              Text('Lihat Resep')
                            ],
                          )
                        ],
                      ),
                      const Gap(20),
                      const Column(
                        children: [
                          Icon(Icons.favorite_border_outlined),
                          Gap(5),
                          Icon(Icons.bookmark_border_outlined)
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )),
    );
  }
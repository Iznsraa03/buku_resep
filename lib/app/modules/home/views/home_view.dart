import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
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
              const Gap(20),
              txtReq(),
              const Gap(20),
              rekomendasi()
            ],
          ),
        ),
      ],
    ));
  }

  Column txtReq() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Rekomendasi',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text('Resep Untuk Anda!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
      ],
    );
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

  Row rekomendasi() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 209,
          width: 186,
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Image.asset('assets/img/rendang.png'),
              const Gap(5),
              titleReq(title: 'Rendang')
            ],
          ),
        ),
        const Gap(5),
        Container(
          height: 209,
          width: 186,
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/img/tiramisu.png'),
              const Gap(5),
              titleReq(title: 'Tiramisu')
            ],
          ),
        ),
      ],
    );
  }

  Row titleReq({required String title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Row(
              children: [Gap(5),Icon(Icons.description), Gap(5), Text('Description')],
            )
          ],
        ),
        const Gap(25),
        const Icon(Icons.favorite_border_outlined),
        const Icon(Icons.bookmark_border_outlined)
      ],
    );
  }
}

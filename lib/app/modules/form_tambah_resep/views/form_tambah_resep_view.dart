import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../controllers/form_tambah_resep_controller.dart';

class FormTambahResepView extends GetView<FormTambahResepController> {
  const FormTambahResepView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController namaResepController = TextEditingController();
    final TextEditingController daerahController = TextEditingController();
    final TextEditingController deskripsiController = TextEditingController();
    final TextEditingController resepController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Resep')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              GestureDetector(
                onTap: controller.pickImage,
                child: Obx(() {
                  return controller.selectedImage.value != null
                      ? Image.file(
                          controller.selectedImage.value!,
                          height: 200,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.grey[300],
                          child: const Center(
                            child: Text("Tap to select image"),
                          ),
                        );
                }),
              ),
              const Gap(20),
              formInput(
                controller: namaResepController,
                hint: 'Nama Resep Anda',
              ),
              const Gap(20),
              formInput(
                controller: daerahController,
                hint: 'Asal Daerah',
              ),
              const Gap(20),
              formInput(
                controller: deskripsiController,
                hint: 'Deskripsi Makanan',
              ),
              const Gap(20),
              formInput(
                controller: resepController,
                hint: 'Resep Anda',
                maxLines: 5,
              ),
              const Gap(30),
              ElevatedButton(
                onPressed: () {
                  controller.saveRecipe(
                    namaResepController.text,
                    deskripsiController.text,
                    resepController.text,
                    daerahController.text
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.orange),
                ),
                child: const Text(
                  'Tambah',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextField formInput({
    required TextEditingController controller,
    required String hint,
    int? maxLines,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines ?? 1,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: hint,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
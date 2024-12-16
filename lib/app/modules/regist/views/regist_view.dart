import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/regist_controller.dart';

class RegistView extends GetView<RegistController> {
  const RegistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sign Up Title
                const Center(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                
                // Username TextField
                const Text('Username', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                TextField(
                  controller: controller.usernameController,
                  decoration: const InputDecoration(
                    hintText: 'Masukkan Username',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Email TextField
                const Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                TextField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                    hintText: 'Masukkan Email',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Password TextField
                const Text('Password', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Obx(() => TextField(
                  controller: controller.passwordController,
                  obscureText: controller.isPasswordHidden.value,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(controller.isPasswordHidden.value
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        controller.togglePasswordVisibility();
                      },
                    ),
                    border: const OutlineInputBorder(),
                  ),
                )),
                const SizedBox(height: 20),
                
                // Confirm Password TextField
                const Text('Confirm Password', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Obx(() => TextField(
                  controller: controller.confirmPasswordController,
                  obscureText: controller.isConfirmPasswordHidden.value,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Kembali Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(controller.isConfirmPasswordHidden.value
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        controller.toggleConfirmPasswordVisibility();
                      },
                    ),
                    border: const OutlineInputBorder(),
                  ),
                )),
                const SizedBox(height: 30),
                
                // Sign Up Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.handleSignUp();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
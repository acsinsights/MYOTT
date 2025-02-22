import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Home/Main_screen.dart';
import 'Controller/auth_controller.dart';



class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 180),

            // OTT Logo
            Image(image: AssetImage("assets/Icons/app_logo.png"),height: 40,),

            const SizedBox(height: 50),

            // Curved Container
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Register Title
                  Text(
                    "Register",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  // Subtitle
                  Text(
                    "Welcome, please create your account",
                    style: GoogleFonts.poppins(
                      color: Colors.redAccent,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Name Field
                  customTextField(Icons.person, "Enter Your Name"),

                  const SizedBox(height: 15),

                  // Mobile Number Field
                  customTextField(Icons.phone, "Enter Your Mobile Number"),

                  const SizedBox(height: 15),

                  // Email Field
                  customTextField(Icons.email, "Enter Your email address"),

                  const SizedBox(height: 30),

                  // Register Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                      authController.register();
                        // Handle Registration Action
                      },
                      child: Text(
                        "Register",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Custom Text Field Widget
  Widget customTextField(IconData icon, String hintText) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.redAccent),
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(color: Colors.white60),
        filled: true,
        fillColor: Colors.black,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
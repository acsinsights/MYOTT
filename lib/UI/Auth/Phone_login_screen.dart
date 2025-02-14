import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myott/UI/Auth/register_screen.dart';

import 'otp_verification.dart';



class Phone_login_screen extends StatelessWidget {
  const Phone_login_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // OTT Logo
            Image(image: AssetImage("assets/Icons/app_logo.png"),height: 40,),
            const SizedBox(height: 10),

            // Welcome Text
            Text(
              "Welcome Back to OTT Demo",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "We have eagerly awaited your return.",
              style: GoogleFonts.poppins(
                color: Colors.white60,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 30),

            // Phone Number Input Field
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white54),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.call, color: Colors.white),
                  const SizedBox(width: 8),
                  const Text(
                    "+91",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: "1234567890",
                        hintStyle: TextStyle(color: Colors.white60),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Get Verification Code Button
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
                  Get.to(OtpVerificationScreen());


                },
                child: Text(
                  "Get Verification Code",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // OR Divider
            Row(
              children: [
                Expanded(
                  child: Divider(color: Colors.white60),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "OR",
                    style: GoogleFonts.poppins(
                      color: Colors.white60,
                      fontSize: 14,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(color: Colors.white60),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Google Sign-in Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/Icons/search.png', // Ensure this image is in assets
                      height: 24,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Sign in with Google",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?",style: TextStyle(
                  color: Colors.white60,
                  fontSize: 16,
                ),),
                InkWell(
                  onTap: (){
                    Get.to(RegisterScreen());
                  },
                  child: Text("Sign Up",style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),),
                )
              ],
            ),
            SizedBox(height: 40,),

            // Terms & Policies Text
            Text(
              "By signing you agree to our ",
              style: GoogleFonts.poppins(
                color: Colors.white60,
                fontSize: 14,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                "Terms and Policies",
                style: GoogleFonts.poppins(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
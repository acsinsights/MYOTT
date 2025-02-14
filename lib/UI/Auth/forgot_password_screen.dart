import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'fogot_otp_verification_screen.dart';


class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailOrMobileController = TextEditingController();

  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },),
        elevation: 0,
        title: Text("Forgot Password", style: GoogleFonts.poppins(
          color: Colors.white
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image(image: AssetImage("assets/Icons/app_logo.png"),height: 40,),
            ),
            SizedBox(height: 50,),
            Text(
              "Enter your Email or Mobile Number",
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailOrMobileController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Email or Mobile",
                hintStyle: GoogleFonts.poppins(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: () {
                // Simulate checking if it's email or mobile
                bool isEmail = emailOrMobileController.text.contains("@");

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForgotOtpVerificationScreen(isEmail: isEmail),
                  ),
                );
              },
              child: Text(
                "Send OTP / Reset Link",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
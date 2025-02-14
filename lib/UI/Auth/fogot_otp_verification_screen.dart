import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myott/UI/Auth/reset_password_screen.dart';

class ForgotOtpVerificationScreen extends StatelessWidget {
  final bool isEmail;
  final TextEditingController otpController = TextEditingController();

  ForgotOtpVerificationScreen({super.key, required this.isEmail});

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
        title: Text("Verify OTP", style: GoogleFonts.poppins(
            color: Colors.white
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isEmail
                ? Text(
              "A reset link has been sent to your email.",
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter the OTP sent to your mobile",
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: otpController,
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter OTP",
                    hintStyle: GoogleFonts.poppins(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.grey[900],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
                );
              },
              child: Text(isEmail ? "Continue" : "Verify OTP", style: GoogleFonts.poppins(fontSize: 16,color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

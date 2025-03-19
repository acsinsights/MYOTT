import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myott/UI/Auth/Controller/auth_controller.dart';
import 'package:myott/UI/Home/Main_screen.dart';
import '../../../Core/Utils/app_colors.dart';
import '../../../Core/Utils/app_text_styles.dart';
import '../../Components/custom_button.dart';
import 'otp_controller.dart';

class OtpBottomSheet extends StatelessWidget {
  final OtpController otpController = Get.find<OtpController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 350.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          border: Border(
            top: BorderSide(color: Colors.white, width: 3),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),

            Text("OTP Verification".tr, style: AppTextStyles.Headingb4),

            SizedBox(height: 5),

            Text(
              "Check your SMS inbox and enter the code you received.".tr,
              textAlign: TextAlign.center,
              style: AppTextStyles.SubHeading2,
            ),

            SizedBox(height: 20),

            TextField(
              controller: otpController.otpController,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              cursorColor: Colors.red,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter OTP",
                hintStyle: TextStyle(color: Colors.white54),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
                border: InputBorder.none,
              ),
            ),

            SizedBox(height: 10),

            Obx(() => otpController.timerValue.value > 0
                ? Text(
              "Resend OTP in ${otpController.timerValue.value} sec",
              style: TextStyle(color: Colors.red, fontSize: 16),
            )
                : GestureDetector(
              onTap: () => authController.sendOtp(), // ✅ Resend OTP
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Didn't get the OTP? ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: "Resend OTP",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )),

            SizedBox(height: 20),

            CustomButton(
              width: double.infinity,
              text: "Verify OTP".tr,

              onPressed: () => authController.verifyOtp(),
              backgroundColor: AppColors.primary,
            ),

            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myott/services/auth_service.dart';
import 'package:myott/services/api_service.dart';
import '../../../Config/app_images.dart';
import '../../../Core/Utils/app_colors.dart';
import '../../../Core/Utils/app_text_styles.dart';
import '../../Components/custom_button.dart';
import '../../Components/custom_text_field.dart';
import '../Controller/auth_controller.dart';
import '../Otp/otp_bottom_sheet.dart';
import '../Otp/otp_controller.dart';
class LoginPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController(AuthService(ApiService())));
  final OtpController otpController = Get.put(OtpController());

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/background.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.5), // Overlay for readability
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.h),

                      /// **App Logo**
                      Image.asset(AppImages.applogo, height: 40.h),
                      SizedBox(height: 20.h),

                      /// **Welcome Text**
                      Text("welcome".tr, style: AppTextStyles.Headingb4),
                      SizedBox(height: 5.h),
                      Text("welcomeSub".tr, style: AppTextStyles.SubHeading2),

                      SizedBox(height: 30.h),
                      Obx(() => authController.isPhoneLogin.value
                          ? PhoneNumberField(
                        controller: authController.inputController,
                        onChanged: (phone) {
                          authController.mobileNumber.value = phone;
                        },
                      )
                          : CustomTextField(
                        controller: authController.inputController,
                        hintText: "Enter Email".tr,
                        keyboardType: TextInputType.emailAddress,
                      )),


                      SizedBox(height: 20.h),

                      CustomButton(
                        width: double.infinity,
                        text: "Get OTP".tr,
                        onPressed: () async {
                          if (authController.isPhoneLogin.value) {
                            String fullPhoneNumber = authController.mobileNumber.value.trim();

                            if (fullPhoneNumber.isEmpty || !fullPhoneNumber.startsWith("+")) {
                              Get.snackbar("Error", "Please enter a valid phone number",
                                  snackPosition: SnackPosition.TOP,
                                  colorText: Colors.white,
                                  backgroundColor: Colors.black);
                              return;
                            }

                            await authController.sendOtp().then((_) {
                              if (authController.otpSent.value) {
                                Get.bottomSheet(OtpBottomSheet());
                              } else {
                                Get.snackbar("Error", "Failed to send OTP. Try again.",
                                    snackPosition: SnackPosition.TOP,
                                    colorText: Colors.white,
                                    backgroundColor: Colors.red);
                              }
                            });
                          } else {
                            String email = authController.inputController.text.trim();
                            if (!GetUtils.isEmail(email)) {
                              Get.snackbar("Error", "Please enter a valid email",
                                  snackPosition: SnackPosition.TOP,
                                  colorText: Colors.white,
                                  backgroundColor: Colors.black);
                              return;
                            }

                            await authController.sendOtp();
                          }
                        },
                      ),
                      SizedBox(height: 20.h),

                      /// **OR Divider**
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.white60)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Text("or".tr, style: AppTextStyles.SubHeading2),
                          ),
                          Expanded(child: Divider(color: Colors.white60)),
                        ],
                      ),

                      SizedBox(height: 20.h),

                      /// **Toggle Login Mode Button (Email <-> Phone)**
                      Obx(() => CustomButton(
                        width: double.infinity,
                        backgroundColor: Color(0xff191818),
                        text: authController.isPhoneLogin.value
                            ? "Login Using Email".tr
                            : "Login Using Phone".tr,
                        onPressed: authController.toggleLoginMethod,
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

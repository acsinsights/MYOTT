import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Auth/register_screen.dart';

import '../../Config/app_images.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_text_styles.dart';
import '../Components/custom_button.dart';
import 'Component/custom_text_field.dart';
import 'Controller/auth_controller.dart';



class LoginPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body:Stack(
children: [
  Positioned.fill(
    child: Image.asset(
      "assets/images/background.jpg", // Make sure the image is in the correct path
      fit: BoxFit.cover,
    ),
  ),
  Container(
    color: Colors.black.withOpacity(0.5), // Optional overlay for readability

    child: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                // OTT Logo
                Image(image: const AssetImage(AppImages.applogo),height: 30,),
                const SizedBox(height: 20),

                // Welcome Text
                Text("welcome".tr, style: AppTextStyles.Headingb4),
                const SizedBox(height: 5),
                Text("welcomeSub".tr, style: AppTextStyles.SubHeading2),

                const SizedBox(height: 30),

                CustomTextField(
                  controller: authController.emailController,
                  hintText: "email".tr,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 20),

                // Password Input Field
                CustomTextField(
                  controller: authController.passwordController,
                  hintText: "password".tr,
                  isPassword: true,
                ),

                const SizedBox(height: 10),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => authController.forgotPassword(),
                    child: Text("forgotPassword".tr, style: AppTextStyles.SubHeadingRed2),
                  ),
                ),

                const SizedBox(height: 20),

                // Login Button
                CustomButton(
                  text: "login".tr,
                  onPressed: () => authController.login(),
                  backgroundColor: AppColors.primary, // Optional
                  borderRadius: BorderRadius.circular(15), // Optional
                ),
                const SizedBox(height: 20),

                // OR Divider
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.white60)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text("or".tr, style: AppTextStyles.SubHeading2),
                    ),
                    Expanded(child: Divider(color: Colors.white60)),
                  ],
                ),

                const SizedBox(height: 20),

                // Google Sign-in Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.inputField,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => authController.googleSignIn(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppImages.google, height: 24),
                        const SizedBox(width: 10),
                        Text("SignInGoogle".tr, style: AppTextStyles.buttonText),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("DontHaveAcc".tr,style:AppTextStyles.SubHeading1),
                    InkWell(
                      onTap: (){
                        authController.register();
                      },
                      child: Text("SignUp".tr,style: AppTextStyles.SubHeadingRed1),
                    )
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    ),
  ),
],
      )
    );
  }
}

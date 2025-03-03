import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Core/Utils/app_colors.dart';
import '../../../Core/Utils/app_text_styles.dart';


class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final ValueChanged<String>? onChanged; // Added onChanged callback

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.onChanged, // Pass onChanged function
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(color: AppColors.white),
      onChanged: onChanged, // Assign onChanged callback
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.SubHeading2,
        filled: true,
        fillColor: AppColors.inputField,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: AppColors.subwhite)
            : null,
        suffixIcon: suffixIcon != null
            ? GestureDetector(
          onTap: onSuffixTap ?? () {},
          child: Icon(suffixIcon, color: AppColors.subwhite),
        )
            : null,
      ),
    );
  }
}

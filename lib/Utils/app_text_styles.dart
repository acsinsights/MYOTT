import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  static TextStyle heading = GoogleFonts.poppins(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.w500);
  static TextStyle subText = GoogleFonts.poppins(color: AppColors.subwhite, fontSize: 14);
  static TextStyle redsubText = GoogleFonts.poppins(color: Colors.red, fontSize: 14);
  static TextStyle subText2 = GoogleFonts.poppins(color: AppColors.subwhite, fontSize: 12);

  static TextStyle buttonText = GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.white);
  static TextStyle linkText = GoogleFonts.poppins(color: Colors.red, fontSize: 14, fontWeight: FontWeight.w500);
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {

      static TextStyle get heading => GoogleFonts.poppins(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
      );

      static TextStyle get Headingb => GoogleFonts.poppins(color: AppColors.text, fontSize: 28.sp, fontWeight: FontWeight.bold,);
      static TextStyle get Heading => GoogleFonts.poppins(color: AppColors.text, fontSize: 28.sp);

      static TextStyle get Headingb1 => GoogleFonts.poppins(color: AppColors.text, fontSize: 26.sp, fontWeight: FontWeight.bold,);
      static TextStyle get Heading1 => GoogleFonts.poppins(color: AppColors.text, fontSize: 26.sp);

      static TextStyle get Headingb2 => GoogleFonts.poppins(color: AppColors.text, fontSize: 24.sp, fontWeight: FontWeight.bold,);
      static TextStyle get HeadingbLackB2 => GoogleFonts.poppins(color: AppColors.background, fontSize: 24.sp, fontWeight: FontWeight.bold,);
      static TextStyle get HeadingbRed2 => GoogleFonts.poppins(color: AppColors.primary2, fontSize: 24.sp, fontWeight: FontWeight.bold,);
      static TextStyle get Heading2 => GoogleFonts.poppins(color: AppColors.text, fontSize: 24.sp);

      static TextStyle get Headingb3 => GoogleFonts.poppins(color: AppColors.text, fontSize: 22.sp, fontWeight: FontWeight.bold,);
      static TextStyle get Heading3 => GoogleFonts.poppins(color: AppColors.text, fontSize: 22.sp);

      static TextStyle get Headingb4 => GoogleFonts.poppins(color: AppColors.text, fontSize: 20.sp, fontWeight: FontWeight.bold,);
      static TextStyle get Heading4 => GoogleFonts.poppins(color: AppColors.text, fontSize: 20.sp);

      static TextStyle get SubHeadingb=> GoogleFonts.poppins(color: AppColors.text, fontSize: 18.sp, fontWeight: FontWeight.bold,);
      static TextStyle get SubHeading=> GoogleFonts.poppins(color: AppColors.text, fontSize: 18.sp);

      static TextStyle get SubHeadingb1=> GoogleFonts.poppins(color: AppColors.text, fontSize: 16.sp, fontWeight: FontWeight.bold,);
      static TextStyle get SubHeadingW1=> GoogleFonts.poppins(color: AppColors.text, fontSize: 16.sp);
      static TextStyle get SubHeading1=> GoogleFonts.poppins(color: AppColors.subText, fontSize: 16.sp);
      static TextStyle get SubHeadingRed1=> GoogleFonts.poppins(color: AppColors.primary2, fontSize: 16.sp);
      static TextStyle get SubHeadingRed1Bold=> GoogleFonts.poppins(color: AppColors.primary2, fontSize: 16.sp,fontWeight: FontWeight.bold);
      static TextStyle get buttonText => GoogleFonts.poppins(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.text);

      static TextStyle get SubHeadingb2=> GoogleFonts.poppins(color: AppColors.text, fontSize: 14.sp, fontWeight: FontWeight.bold,);
      static TextStyle get SubHeadingRed2=> GoogleFonts.poppins(color: AppColors.primary2, fontSize: 14.sp, );
      static TextStyle get SubHeading2=> GoogleFonts.poppins(color: AppColors.subText, fontSize: 14.sp);
      static TextStyle get SubHeadingblue2=> GoogleFonts.poppins(color: AppColors.blue, fontSize: 14.sp);
      static TextStyle get SubHeadingGrey2=> GoogleFonts.poppins(color: Colors.grey[400], fontSize: 14.sp);

      static TextStyle get SubHeadingb3=> GoogleFonts.poppins(color: AppColors.text, fontSize: 12.sp, fontWeight: FontWeight.bold,);
      static TextStyle get SubHeadingw3=> GoogleFonts.poppins(color: AppColors.text, fontSize: 12.sp, );
      static TextStyle get SubHeading3=> GoogleFonts.poppins(color: AppColors.subText, fontSize: 12.sp);
      static TextStyle get SubHeadingblue=> GoogleFonts.poppins(color: Colors.blue, fontSize: 12.sp);

      static TextStyle get SubHeadingb4=> GoogleFonts.poppins(color: AppColors.text, fontSize: 10.sp, fontWeight: FontWeight.bold,);
      static TextStyle get SubHeading4=> GoogleFonts.poppins(color: AppColors.text, fontSize: 10.sp);
      // static TextStyle get SubHeading4=> GoogleFonts.poppins(color: AppColors.text, fontSize: 10.sp);
      static TextStyle get SubHeadingRed4=> GoogleFonts.poppins(color: AppColors.primary2, fontSize: 10.sp);
      static TextStyle get SubHeadingSubW4=> GoogleFonts.poppins(color: AppColors.subText, fontSize: 10.sp);


      static final headingBlackBold20 = TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.textBlack);
      static final textBlack16Bold = TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.textBlack);
      static final textGray14 = TextStyle(fontSize: 14.sp, color: AppColors.textGray);
      static final textGray12 = TextStyle(fontSize: 12.sp, color: AppColors.textGray);
      static final textBlack14 = TextStyle(fontSize: 14.sp, color: AppColors.textBlack);
      static final textHint = TextStyle(fontSize: 14.sp, color: AppColors.textGray);



}

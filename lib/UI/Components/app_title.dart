import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myott/Utils/app_text_styles.dart';

class AppTitle extends StatelessWidget {
  final String title;
  const AppTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.SubHeadingb1,
        ),

      ],
    );
  }
}

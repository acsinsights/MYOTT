import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myott/Utils/app_colors.dart';
import 'package:myott/Utils/app_text_styles.dart';

class TVseriesSynopsis extends StatelessWidget {
  final String description;

  const TVseriesSynopsis({required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Synopsis", style: AppTextStyles.SubHeadingb1),
        SizedBox(height: 5),
        Text(description, style: AppTextStyles.SubHeadingGrey2),
      ],
    );
  }
}

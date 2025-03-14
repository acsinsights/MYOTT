import 'package:flutter/material.dart';

import '../../Core/Utils/app_colors.dart';
import '../../Core/Utils/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double? width;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Color? borderColor;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.borderRadius,
    this.borderColor,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary, // Default to primary color
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(10), // Default 10px
            side: BorderSide(color: borderColor ?? Colors.transparent, width: 2), // Border color
          ),
        ),
        onPressed: onPressed,
        child: Text(text, style: AppTextStyles.buttonText),
      ),
    );
  }
}

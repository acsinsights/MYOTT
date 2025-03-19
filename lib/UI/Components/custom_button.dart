import 'package:flutter/material.dart';

import '../../Core/Utils/app_colors.dart';
import '../../Core/Utils/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final double? width;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Color? borderColor;

  const CustomButton({
    Key? key,
    this.text,
    this.child,
    required this.onPressed,
    this.backgroundColor,
    this.borderRadius,
    this.borderColor,
    this.width,
  })  : assert(text != null || child != null, 'Either text or child must be provided'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(10),
            side: BorderSide(color: borderColor ?? Colors.transparent, width: 2),
          ),
        ),
        onPressed: onPressed,
        child: child ?? Text(text!, style: AppTextStyles.buttonText),
      ),
    );
  }
}
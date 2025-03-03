import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Core/Utils/app_text_styles.dart';

class AlertRows extends StatelessWidget {
  final IconData icon;
  final String text;

  const AlertRows({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 14),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.SubHeadingSubW4,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Core/Utils/app_text_styles.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final GestureTapCallback? onTap;
  final bool showAll;

  const SectionTitle({
    Key? key,
    required this.title,
    this.onTap,
    this.showAll = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.SubHeadingb1,
          ),
          if (showAll)
            InkWell(
              onTap: onTap,
              child: Text(
                "Showall".tr,
                style: AppTextStyles.SubHeadingRed2,
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myott/UI/Components/network_image_widget.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';

class EpisodeCard extends StatelessWidget {
  final String title;
  final String image;
  const EpisodeCard(this.title, this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: NetworkImageWidget(
                imageUrl: image,
                width: 120,
                height: 70)
          ),
          SizedBox(height: 5),
          Text(
            title,
            style: AppTextStyles.SubHeadingb3,
          ),
        ],
      ),
    );
  }
}

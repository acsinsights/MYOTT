import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      child: Container(
        width: 130.w,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: NetworkImageWidget(imageUrl: image,errorAsset: "assets/images/CommingSoon/comming_movie.png",height: 80,),
            ),
            SizedBox(height: 5),
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.SubHeadingb3,
            ),
          ],
        ),
      ),
    );
  }
}

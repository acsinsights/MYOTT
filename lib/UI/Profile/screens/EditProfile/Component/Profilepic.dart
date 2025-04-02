import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Components/network_image_widget.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key,
    required this.image,
    this.isShowPhotoUpload = false,
    this.imageUploadBtnPress,
    this.localImage, // Local image file
  });

  final String image;
  final File? localImage; // Nullable File
  final bool isShowPhotoUpload;
  final VoidCallback? imageUploadBtnPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.red.withOpacity(0.08),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            height: 100.w,
            width: 100.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: Colors.red
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: localImage != null
                    ? Image.file(localImage!, fit: BoxFit.cover) // ✅ Show selected image
                    : NetworkImageWidget(
                  imageUrl: image,
                  errorAsset: "assets/Avtars/avtar.jpg",
                ),
            ),
          ),
          InkWell(
            onTap: imageUploadBtnPress,
            child: CircleAvatar(
              radius: 13,
              backgroundColor: Colors.red,
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}

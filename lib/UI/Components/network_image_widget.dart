import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myott/UI/Components/ShimmerLoader.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final String? errorAsset;

  const NetworkImageWidget({
    Key? key,
    required this.imageUrl,
     this.width,
     this.height,
    this.fit = BoxFit.cover,
    this.errorAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => ShimmerLoader(), // Shimmer effect
      errorWidget: (context, url, error) => Image.asset(
        errorAsset ?? 'assets/images/default_placeholder.png',
        width: width,
        height: height,
        fit: fit,
      ),
      fadeInDuration: Duration(milliseconds: 500), // Fade-in effect
      fadeOutDuration: Duration(milliseconds: 200),
    );
  }
}

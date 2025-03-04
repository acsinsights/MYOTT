import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';


class FooterWidget extends StatelessWidget {
  final String facebookUrl;
  final String linkedinUrl;
  final String twitterUrl;
  final String instagramUrl;

  const FooterWidget({
    Key? key,
    required this.facebookUrl,
    required this.linkedinUrl,
    required this.twitterUrl,
    required this.instagramUrl,
  }) : super(key: key);

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      color: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIcon(LucideIcons.facebook, facebookUrl),
              _buildIcon(LucideIcons.linkedin, linkedinUrl),
              _buildIcon(LucideIcons.twitter, twitterUrl),
              _buildIcon(LucideIcons.instagram, instagramUrl),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            "© 2025 Your App Name. All rights reserved.",
            style: TextStyle(
              color: Colors.white60,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon, String url) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Icon(icon, color: Colors.white, size: 24.sp),
      ),
    );
  }
}

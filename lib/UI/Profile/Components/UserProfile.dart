import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myott/UI/Components/network_image_widget.dart';
import 'package:myott/UI/Profile/Controller/ProfileController.dart';
import 'package:myott/UI/Profile/screens/EditProfile/EditProfileScreen.dart';
import 'package:myott/UI/Profile/screens/create_profile.dart';
import 'package:myott/UI/Profile/screens/edit_User_profile.dart';

class UserProfile extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    profileController.fetchProfileData();

    return Obx(() {
      var user = profileController.user.value;

      if (user == null) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Get.to(() => EditProfileScreen());
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Container(
                    height: 60.w,
                    width: 60.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.red),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: NetworkImageWidget(
                          imageUrl: user.image,
                          errorAsset: "assets/Avtars/avtar.jpg",
                        )),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name ?? "Unknown", // ✅ Dynamic Name
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          user.email ?? "No email", // ✅ Dynamic Email
                          style: GoogleFonts.poppins(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       "Profile",
          //       style: GoogleFonts.poppins(
          //         color: Colors.white,
          //         fontSize: 18,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //     TextButton(
          //       onPressed: () => Get.to(() => CreateProfileScreen()),
          //       child: Text(
          //         "Add Profile",
          //         style: GoogleFonts.poppins(color: Colors.red, fontSize: 16),
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 8),
          //
          // Container(
          //   padding: const EdgeInsets.all(12),
          //   width: 140.w,
          //   height: 180.h,
          //   decoration: BoxDecoration(
          //     border: Border.all(color: Colors.red),
          //     borderRadius: BorderRadius.circular(8),
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Container(
          //         height: 60.w,
          //         width: 60.w,
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(30),
          //             color: Colors.red),
          //         child: ClipRRect(
          //             borderRadius: BorderRadius.circular(30),
          //             child: NetworkImageWidget(
          //               imageUrl: user.image,
          //               errorAsset: "assets/Avtars/avtar.jpg",
          //             )),
          //       ),
          //       SizedBox(height: 6),
          //       Text(
          //         textAlign: TextAlign.center,
          //         user.name ?? "Unknown",
          //         style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
          //       ),
          //       TextButton.icon(
          //         onPressed: () => Get.to(() => EditUserProfileScreen()),
          //         icon:  Icon(Icons.edit, size: 14, color: Colors.white70),
          //         label: Text(
          //           "Edit",
          //           style: GoogleFonts.poppins(color: Colors.white70),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myott/Data/UserData.dart';
import 'package:myott/UI/Profile/screens/EditProfile/Edit_profile.dart';
import 'package:myott/UI/Profile/screens/create_profile.dart';
import 'package:myott/UI/Profile/screens/edit_User_profile.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // User Profile
        InkWell(
          onTap: () => Get.to(() => EditProfileScreen()),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/actors/actor1.png"),
                  radius: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "John Doe",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "johndoe123@gmail.com",
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

        // Profile Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Profile",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () => Get.to(() => CreateProfileScreen()),
              child: Text(
                "Add Profile",
                style: GoogleFonts.poppins(color: Colors.red, fontSize: 16),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Profile Avatar Box
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.red,
                radius: 24,
                child: Text("JO", style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 6),
              Text(
                "John Doe",
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
              ),
              TextButton.icon(
                onPressed: () => Get.to(() => EditUserProfileScreen()),
                icon: const Icon(Icons.edit, size: 14, color: Colors.white70),
                label: Text(
                  "Edit",
                  style: GoogleFonts.poppins(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

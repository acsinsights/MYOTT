import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'EditProfileDetailsScreen.dart';
import 'create_profile.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  List<Map<String, dynamic>> profiles = [
    {"name": "John Doe", "image": "assets/Avtars/person1.png"},
    {"name": "Kids", "image": "assets/Avtars/person2.png"},
  ];

  // Function to Update Name After Editing
  void _updateProfileName(int index, String newName) {
    setState(() {
      profiles[index]["name"] = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Edit Profile",
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 50),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 30,
              mainAxisSpacing: 20,
            ),
            itemCount: profiles.length,
            itemBuilder: (context, index) {
              return _buildProfileTile(profiles[index], index);
            },
          ),
          InkWell(
              onTap: (){

              },
              child: _buildAddProfileTile()
          ),
        ],
      ),
    );
  }

  // Profile Tile
  Widget _buildProfileTile(Map<String, dynamic> profile, int index) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(profile["image"]),
            ),
            Positioned(
              right: 4,
              bottom: 4,
              child: GestureDetector(
                onTap: () {

                  // Navigate to Edit Profile Screen with Pre-filled Data
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileDetailsScreen(
                        initialName: profiles[index]["name"],
                        initialAvatar: profiles[index]["image"],
                        onSave: (newName, newAvatar) {
                          setState(() {
                            profiles[index]["name"] = newName;
                            profiles[index]["image"] = newAvatar;
                          });
                        },
                      ),
                    ),
                  );

                },
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.black54,
                  child: Icon(Icons.edit, color: Colors.white, size: 16),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          profile["name"],
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  // Add Profile Tile - Centered
  Widget _buildAddProfileTile() {
    return GestureDetector(onTap: (){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>CreateProfileScreen(),
        ),
      );
    },
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[800],
            child: Icon(Icons.add, color: Colors.white, size: 30),
          ),
          SizedBox(height: 8),
          Text(
            "Add",
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

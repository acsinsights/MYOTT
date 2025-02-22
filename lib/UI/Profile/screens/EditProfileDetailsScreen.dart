import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileDetailsScreen extends StatefulWidget {
  final String initialName;
  final String initialAvatar;
  final Function(String, String) onSave;

  EditProfileDetailsScreen({
    required this.initialName,
    required this.initialAvatar,
    required this.onSave,
  });

  @override
  _EditProfileDetailsScreenState createState() =>
      _EditProfileDetailsScreenState();
}

class _EditProfileDetailsScreenState extends State<EditProfileDetailsScreen> {
  final List<String> avatars = [
    "assets/Avtars/person1.png",
    "assets/Avtars/person2.png",
    "assets/Avtars/person3.png",
    "assets/Avtars/person4.png",
    "assets/Avtars/person5.png",
  ];

  late TextEditingController _nameController;
  late int selectedAvatarIndex;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    selectedAvatarIndex = avatars.indexOf(widget.initialAvatar);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Edit Profile",
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context); // Goes back to the previous screen
            },
          ),
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            SizedBox(height: 20),

            // Scrollable Avatar List
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: avatars.length * 100, // Infinite scrolling effect
                itemBuilder: (context, index) {
                  final realIndex = index % avatars.length;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAvatarIndex = realIndex;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: selectedAvatarIndex == realIndex
                            ? Colors.red
                            : Colors.transparent,
                        child: CircleAvatar(
                          radius: 28,
                          backgroundImage: AssetImage(avatars[realIndex]),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 20),

            // Selected Avatar
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(avatars[selectedAvatarIndex]),
            ),

            SizedBox(height: 30),

            // Name Input Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextField(
                controller: _nameController,
                style: GoogleFonts.poppins(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Your Name",
                  labelStyle: GoogleFonts.poppins(color: Colors.white60),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white60)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                ),
              ),
            ),

            Spacer(),

            // Save Button
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: GestureDetector(
                onTap: () {
                  widget.onSave(
                    _nameController.text,
                    avatars[selectedAvatarIndex],
                  );
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blueGrey[900],
                  child: Icon(Icons.check, color: Colors.white, size: 30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateProfileScreen extends StatefulWidget {
  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final List<String> Avtars = [
    "assets/Avtars/person1.png",
    "assets/Avtars/person2.png",
    "assets/Avtars/person3.png",
    "assets/Avtars/person4.png",
    "assets/Avtars/person5.png",
  ];

  int selectedpersonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title:  Text(
            "Create Profile",
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),

          ),
          leading:  IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context); // Goes back to the previous screen
            },
          ),
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            // Back button and title

            SizedBox(height: 20),
      
            // Scrollable person List
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Avtars.length * 100, // Infinite scrolling effect
                itemBuilder: (context, index) {
                  final realIndex = index % Avtars.length;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedpersonIndex = realIndex;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: selectedpersonIndex == realIndex ? Colors.red : Colors.transparent,
                        child: CircleAvatar(
                          radius: 28,
                          backgroundImage: AssetImage(Avtars[realIndex]),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
      
            SizedBox(height: 20),
      
            // Selected person
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(Avtars[selectedpersonIndex]),
            ),
      
            SizedBox(height: 30),
      
            // Name Input Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextField(
                style: GoogleFonts.poppins(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Your Name",
                  labelStyle: GoogleFonts.poppins(color: Colors.white60),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                ),
              ),
            ),
      
            Spacer(),
      
            // Check Button
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: GestureDetector(
                onTap: () {
                  // Handle profile creation
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

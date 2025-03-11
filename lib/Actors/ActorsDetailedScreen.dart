import 'package:flutter/material.dart';

class ActorsDetailedScreen extends StatelessWidget {
  final String artistName = "James Williams";
  final String artistImage = "assets/images/artistbanner.jpg"; // Ensure this exists
  final List<String> moviePosters = [
    'assets/images/Groups-1.png',
    'assets/images/Groups-2.png',
    'assets/images/Groups-3.png',
    'assets/images/Groups-4.png',
    'assets/images/Groups-5.png',
    'assets/images/latest-6.png',
    'assets/images/latest-2.png',
    'assets/images/latest-3.png',
    'assets/images/latest-4.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back Button & Profile Image
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(artistImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),

            // Artist Name
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                artistName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Section Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Movies of $artistName",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Movie Grid with fixed height to avoid overflow
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 3 columns like in the image
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.7, // Adjust for movie poster aspect ratio
                  ),
                  itemCount: moviePosters.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        moviePosters[index],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

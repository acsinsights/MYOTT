import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myott/UI/Movie/Model/movie_model.dart';

class MovieListComponent extends StatelessWidget {
  final List<MovieModel> movies; // Updated to accept MovieModel list
  final bool isContinueWatching;

  MovieListComponent({required this.movies, required this.isContinueWatching});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isContinueWatching ? 140 : 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        padding: const EdgeInsets.only(left: 16),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Container(
              width: 120,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(movies[index].bannerUrl), // Use movie poster URL
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  if (isContinueWatching)
                    Positioned(
                      bottom: 10,
                      left: 8,
                      child: Row(
                        children: [
                          const Icon(Icons.play_arrow, size: 16, color: Colors.white),
                          Text(
                            "E1 E2",
                            style: GoogleFonts.poppins(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  if (isContinueWatching)
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 5,
                        width: 80,
                        color: Colors.redAccent,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

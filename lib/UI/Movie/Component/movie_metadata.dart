import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:myott/Utils/app_text_styles.dart';

class MovieMeta extends StatelessWidget {
  final dynamic movie;
  const MovieMeta({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("4K", style: AppTextStyles.SubHeading3),
        SizedBox(width: 10),
        Icon(Icons.access_time, color: Colors.grey, size: 14),
        SizedBox(width: 5),
        Text("${movie.duration} min", style: AppTextStyles.SubHeading3),
        SizedBox(width: 10),
        Icon(Icons.star, color: Colors.yellow, size: 14),
        SizedBox(width: 5),
        Text("${movie.imdbRating} (IMDb)", style: AppTextStyles.SubHeading3),
        SizedBox(width: 10),
        Text(
          movie.releaseDate != null ? DateFormat('dd MMM yyyy').format(movie.releaseDate!) : "Release Date Unknown",
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}

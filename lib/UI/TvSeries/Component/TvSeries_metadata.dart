// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:myott/UI/TvSeries/Model/TVSeriesDetailsModel.dart';
// import 'package:myott/UI/TvSeries/Model/TvSeriesModel.dart';
// import 'package:myott/Core/Utils/app_text_styles.dart';
//
// class MovieMeta extends StatelessWidget {
//   final SeriesDetailResponse movie;
//   const MovieMeta({required this.movie});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text("4K", style: AppTextStyles.SubHeading3),
//         SizedBox(width: 10),
//         Icon(Icons.access_time, color: Colors.grey, size: 14),
//         SizedBox(width: 5),
//         Text("${movie.meta} min", style: AppTextStyles.SubHeading3),
//         SizedBox(width: 10),
//         Icon(Icons.star, color: Colors.yellow, size: 14),
//         SizedBox(width: 5),
//         // Text("${movie.imdbRating} (IMDb)", style: AppTextStyles.SubHeading3),
//         SizedBox(width: 10),
//         Text(
//           movie.series!.releaseYear ,
//           style: TextStyle(fontSize: 12, color: Colors.grey),
//         ),
//       ],
//     );
//   }
// }

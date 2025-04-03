// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

import 'package:myott/UI/Model/searchable_content.dart';



class SearchModel {
  SearchResults results;

  SearchModel({
    required this.results,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    results: SearchResults.fromJson(json["results"]),
  );

}

class SearchResults {
  List<SearchMTVA> movies;
  List<SearchMTVA> tvSeries;
  List<SearchMTVA> audio;
  List<SearchMTVA> videos;

  SearchResults({
    required this.movies,
    required this.tvSeries,
    required this.audio,
    required this.videos,
  });

  factory SearchResults.fromJson(Map<String, dynamic> json) => SearchResults(
    movies: json["movies"] != null ?  List<SearchMTVA>.from(json["movies"].map((x) => SearchMTVA.fromJson(x))):[],
    tvSeries: json["tv_series"] != null ?   List<SearchMTVA>.from(json["tv_series"].map((x) => SearchMTVA.fromJson(x))):[],
    audio: json["audio"] != null ?    List<SearchMTVA>.from(json["audio"].map((x) => SearchMTVA.fromJson(x))):[],
    videos: json["videos"]!= null ? List<SearchMTVA>.from(json["videos"].map((x) => SearchMTVA.fromJson(x))):[],
  );


}

class SearchMTVA {
  int id;
  String name;
  String slug;
  String thumbnailImg;
  String maturity;
  DateTime releaseYear;
  String? posterImg;

  SearchMTVA({
    required this.id,
    required this.name,
    required this.slug,
    required this.thumbnailImg,
    required this.maturity,
    required this.releaseYear,


    this.posterImg,

  });

  factory SearchMTVA.fromJson(Map<String, dynamic> json) => SearchMTVA(
    id: json["id"]??0,
    name: json["name"]??"",
    slug: json["slug"]??"",
    thumbnailImg: json["thumbnail_img"]??"",
    maturity: json["maturity"]??"",
    releaseYear: json["release_year"] != null
        ? (json["release_year"] is int
        ? DateTime(json["release_year"])  // If it's an int, create a DateTime object
        : DateTime.tryParse(json["release_year"]) ?? DateTime.now())  // If it's a String, parse it safely
        : DateTime.now(), // Default to current date if null
    posterImg: json["poster_img"]??"",

  );

}
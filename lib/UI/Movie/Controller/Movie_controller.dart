import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../services/MovieService.dart';
import '../Model/movie_details_model.dart';

class MovieController extends GetxController {
  final MoviesService moviesService;
  MovieController(this.moviesService);

  var movieDetails =Rxn<MovieDetailsModel>();
  var commentController=TextEditingController();
  var isLoading = false.obs;
  RxBool isExpanded = false.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void fetchMovieDetails(int movieId) async {
    try {
      isLoading(true);

      var fetchedMovieDetails = await moviesService.getMovieDetails(movieId);

      movieDetails.value = fetchedMovieDetails;
    } catch (e) {
      print("Error fetching movie details: $e");
    } finally {
      isLoading(false);
    }
  }

}

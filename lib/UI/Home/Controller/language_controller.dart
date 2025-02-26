import 'package:get/get.dart';
import '../movies_by_lang.dart';
import '../../Movie/Controller/Movie_controller.dart';
import '../../Movie/Model/movie_model.dart';
import '../Model/language_model.dart';


class LanguageController extends GetxController {
  var selectedLanguage = Rxn<LanguageModel>();
  var moviesByLanguage = <MovieModel>[].obs; // Store movies filtered by language

  final List<LanguageModel> languages = [
    LanguageModel(name: "English", translation: "English", image: "assets/images/language/lang1.png", color: 0xFF3B3B98),
    LanguageModel(name: "日本語", translation: "Japanese", image: "assets/images/language/lang2.png", color: 0xFF8D4E3F),
    LanguageModel(name: "中文", translation: "Chinese", image: "assets/images/language/lang3.png", color: 0xFF5D5D81),
    LanguageModel(name: "한국어", translation: "Korean", image: "assets/images/language/lang4.png", color: 0xFF725285),
    LanguageModel(name: "Español", translation: "Spanish", image: "assets/images/language/lang5.png", color: 0xFFA97E36),
    LanguageModel(name: "Français", translation: "French", image: "assets/images/language/lang6.png", color: 0xFF3B8D78),
  ];

  void selectLanguage(LanguageModel language) {
    selectedLanguage.value = language;

    // Fetch the MovieController
    MovieController movieController = Get.find<MovieController>();

    // Filter movies by selected language
    moviesByLanguage.assignAll(
      movieController.movies.where((movie) => movie.languages.contains(language.translation)).toList(),
    );

    // Navigate to movie list screen with filtered movies
    // Get.to(MoviesByLanguageScreen(), arguments: moviesByLanguage);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

}

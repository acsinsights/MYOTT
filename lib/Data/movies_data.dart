
import '../UI/Movie/Model/movie_model.dart';

List<MovieModel> allMovies = [
  MovieModel(
    id: 1,
    title: "Black Dragon",
    imageUrl: "assets/images/movies/SliderMovies/movie-1.png",
    bannerUrl: "assets/images/movies/SliderMovies/movie-1.png",
    description: "An action-packed journey through the underworld of crime.",
    genres: ["Action", "Adventure"],
    tags: ["Epic", "Martial Arts", "Revenge"],
    languages: ["English", "Hindi"],
    duration: 120,
    imdbRating: 8.5,
    releaseDate: DateTime(2023-11-15),
    resolution: "4K",
    seasons: [
      Season(
        seasonNumber: 1,
        episodes: [
          Episode(
            episodeNumber: 1,
            title: "Rise of the Dragon",
            duration: "42m",
            imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
          ),
          Episode(
            episodeNumber: 2,
            title: "Dragon’s Wrath",
            duration: "45m",
            imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
          ),
        ],

      ),
      Season(seasonNumber: 2,
        episodes: [
          Episode(
            episodeNumber: 1,
            title: "Rise of the Dragon",
            duration: "42m",
            imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
          ),
          Episode(
            episodeNumber: 2,
            title: "Dragon’s Wrath",
            duration: "45m",
            imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
          ),
        ],),
      Season(seasonNumber: 3,
        episodes: [
          Episode(
            episodeNumber: 1,
            title: "Rise of the Dragon",
            duration: "42m",
            imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
          ),
          Episode(
            episodeNumber: 2,
            title: "Dragon’s Wrath",
            duration: "45m",
            imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
          ),
        ],),
    ],
    isTrending: true,
    isFeatured: true,
  ),
  MovieModel(
    id: 2,
    title: "Red Horizon",
    imageUrl: "assets/images/movies/SliderMovies/movie-2.png",
    bannerUrl: "assets/images/movies/SliderMovies/movie-2.png",
    description: "A sci-fi thriller about humanity’s survival in space.",
    genres: ["Sci-Fi", "Thriller"],
    tags: ["Space", "Survival", "AI"],
    languages: ["English", "Spanish"],
    duration: 130,
    imdbRating: 7.9,
    releaseDate: DateTime(2024-01-20),
    resolution: "1080p",
    seasons: [    Season(
      seasonNumber: 1,
      episodes: [
        Episode(
          episodeNumber: 1,
          title: "Rise of the Dragon",
          duration: "42m",
          imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
        ),
        Episode(
          episodeNumber: 2,
          title: "Dragon’s Wrath",
          duration: "45m",
          imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
        ),
      ],

    ),
      Season(seasonNumber: 2,
        episodes: [
          Episode(
            episodeNumber: 1,
            title: "Rise of the Dragon",
            duration: "42m",
            imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
          ),
          Episode(
            episodeNumber: 2,
            title: "Dragon’s Wrath",
            duration: "45m",
            imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
          ),
        ],),
      Season(seasonNumber: 3,
        episodes: [
          Episode(
            episodeNumber: 1,
            title: "Rise of the Dragon",
            duration: "42m",
            imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
          ),
          Episode(
            episodeNumber: 2,
            title: "Dragon’s Wrath",
            duration: "45m",
            imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
          ),
        ],),],
    isTrending: false,
    isFeatured: true,
  ),
  MovieModel(
    id: 3,
    title: "Dark Secrets",
    imageUrl: "assets/images/movies/SliderMovies/movie-3.png",
    bannerUrl: "assets/images/movies/SliderMovies/movie-3.png",
    description: "A psychological thriller with unexpected twists.",
    genres: ["Thriller", "Mystery"],
    tags: ["Suspense", "Crime", "Detective"],
    languages: ["English", "French"],
    duration: 110,
    imdbRating: 8.2,
    releaseDate: DateTime(2024-02-10),
    resolution: "4K",
    seasons: [
      Season(
        seasonNumber: 1,
        episodes: [
          Episode(
            episodeNumber: 1,
            title: "Rise of the Dragon",
            duration: "42m",
            imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
          ),
          Episode(
            episodeNumber: 2,
            title: "Dragon’s Wrath",
            duration: "45m",
            imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
          ),
        ],

      ),
      Season(seasonNumber: 2,
        episodes: [
          Episode(
            episodeNumber: 1,
            title: "Rise of the Dragon",
            duration: "42m",
            imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
          ),
          Episode(
            episodeNumber: 2,
            title: "Dragon’s Wrath",
            duration: "45m",
            imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
          ),
        ],),
      Season(seasonNumber: 3,
        episodes: [
          Episode(
            episodeNumber: 1,
            title: "Rise of the Dragon",
            duration: "42m",
            imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
          ),
          Episode(
            episodeNumber: 2,
            title: "Dragon’s Wrath",
            duration: "45m",
            imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
          ),
        ],),
    ],
    isTrending: true,
    isFeatured: false,
  ),
];

//Slider Movies
List<MovieModel> sliderMoviesList = [
  MovieModel(
    id: 1,
    title: "Black Dragon",
    imageUrl: "assets/images/movies/SliderMovies/movie-1.png",
    bannerUrl: "assets/images/movies/SliderMovies/movie-1.png",
    description: "An action-packed journey through the underworld of crime.",
    genres: ["Action", "Adventure"],
    tags: ["Epic", "Martial Arts", "Revenge"],
    languages: ["English", "Hindi"],
    duration: 120,
    imdbRating: 8.5,
    releaseDate: DateTime(2023-11-15),
    resolution: "4K",
    seasons: [    Season(
      seasonNumber: 1,
      episodes: [
        Episode(
          episodeNumber: 1,
          title: "Rise of the Dragon",
          duration: "42m",
          imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
        ),
        Episode(
          episodeNumber: 2,
          title: "Dragon’s Wrath",
          duration: "45m",
          imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
        ),
      ],

    ),
      Season(seasonNumber: 2,
        episodes: [
          Episode(
            episodeNumber: 1,
            title: "Rise of the Dragon",
            duration: "42m",
            imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
          ),
          Episode(
            episodeNumber: 2,
            title: "Dragon’s Wrath",
            duration: "45m",
            imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
          ),
        ],),
      Season(seasonNumber: 3,
        episodes: [
          Episode(
            episodeNumber: 1,
            title: "Rise of the Dragon",
            duration: "42m",
            imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
          ),
          Episode(
            episodeNumber: 2,
            title: "Dragon’s Wrath",
            duration: "45m",
            imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
          ),
        ],),],
    isTrending: false,
    isFeatured: false,
  ),
  MovieModel(
    id: 2,
    title: "Red Horizon",
    imageUrl: "assets/images/movies/SliderMovies/movie-2.png",
    bannerUrl: "assets/images/movies/SliderMovies/movie-2.png",
    description: "A sci-fi thriller about humanity’s survival in space.",
    genres: ["Sci-Fi", "Thriller"],
    tags: ["Space", "Survival", "AI"],
    languages: ["English", "Spanish"],
    duration: 130,
    imdbRating: 7.9,
    releaseDate: DateTime(2024-01-20),
    resolution: "1080p",
    seasons: [    Season(
      seasonNumber: 1,
      episodes: [
        Episode(
          episodeNumber: 1,
          title: "Rise of the Dragon",
          duration: "42m",
          imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
        ),
        Episode(
          episodeNumber: 2,
          title: "Dragon’s Wrath",
          duration: "45m",
          imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
        ),
      ],

    ),
      Season(seasonNumber: 2,
        episodes: [
          Episode(
            episodeNumber: 1,
            title: "Rise of the Dragon",
            duration: "42m",
            imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
          ),
          Episode(
            episodeNumber: 2,
            title: "Dragon’s Wrath",
            duration: "45m",
            imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
          ),
        ],),
      Season(seasonNumber: 3,
        episodes: [
          Episode(
            episodeNumber: 1,
            title: "Rise of the Dragon",
            duration: "42m",
            imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
          ),
          Episode(
            episodeNumber: 2,
            title: "Dragon’s Wrath",
            duration: "45m",
            imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
          ),
        ],),],
    isTrending: false,
    isFeatured: false,
  ),
  MovieModel(
    id: 3,
    title: "Dark Secrets",
    imageUrl: "assets/images/movies/SliderMovies/movie-3.png",
    bannerUrl: "assets/images/movies/SliderMovies/movie-3.png",
    description: "A psychological thriller with unexpected twists.",
    genres: ["Thriller", "Mystery"],
    tags: ["Suspense", "Crime", "Detective"],
    languages: ["English", "French"],
    duration: 110,
    imdbRating: 8.2,
    releaseDate: DateTime(2023-11-15),
    resolution: "4K",
    seasons: [
      Season(
      seasonNumber: 1,
      episodes: [
        Episode(
          episodeNumber: 1,
          title: "Rise of the Dragon",
          duration: "42m",
          imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
        ),
        Episode(
          episodeNumber: 2,
          title: "Dragon’s Wrath",
          duration: "45m",
          imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
        ),
      ],

    ),
      Season(seasonNumber: 2,
        episodes: [
          Episode(
            episodeNumber: 1,
            title: "Rise of the Dragon",
            duration: "42m",
            imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
          ),
          Episode(
            episodeNumber: 2,
            title: "Dragon’s Wrath",
            duration: "45m",
            imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
          ),
        ],),
      Season(seasonNumber: 3,
        episodes: [
          Episode(
            episodeNumber: 1,
            title: "Rise of the Dragon",
            duration: "42m",
            imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
          ),
          Episode(
            episodeNumber: 2,
            title: "Dragon’s Wrath",
            duration: "45m",
            imageUrl: "assets/images/movies/SliderMovies/movie_big.png",
          ),
        ],),],
    isTrending: false,
    isFeatured: false,
  ),
];
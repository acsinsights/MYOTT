class APIEndpoints {
  static const String send_otp = "send-otp";
  static const String stripePublishablekey ="pk_test_51R3woGCG37UV7MBEuZDyX1QGvAqSY4yxaBUduJyQRX18ucxrozR6ezq6CPSWF0VzJ0JfmlJYeO5KAuAfTYFl8HSp00zD5Er2RF";



  static const String homeEndpoint = "home?secret=06c51069-0171-4f23-bf8f-41c9cd86762d";
  //TvSeries
    static const String tvSeries = "tv-series?secret=06c51069-0171-4f23-bf8f-41c9cd86762d&currency=INR";
    static String tvSeriesDetails(int seriesId) =>
      "tvseries/$seriesId?secret=06c51069-0171-4f23-bf8f-41c9cd86762d";

  static String actorDetails(int actorId) =>
      "actor/$actorId?secret=06c51069-0171-4f23-bf8f-41c9cd86762d";

    //Genre
  static String moviesByGenre(int genreId) =>
      "genre/$genreId?secret=06c51069-0171-4f23-bf8f-41c9cd86762d";


  static String movieDetails(int movieId) =>
      "movie/$movieId?secret=06c51069-0171-4f23-bf8f-41c9cd86762d";

  static  String searchMovies(String searchTerm) => "search?secret=06c51069-0171-4f23-bf8f-41c9cd86762d&searchTerm=$searchTerm";
  static  String pages (String pageName) => "pages/$pageName?secret=06c51069-0171-4f23-bf8f-41c9cd86762d ";


  //setting
  static const String faq = "faq";
  static const String blogs = "blog";
  static String blogDeatils(int blogId) =>
      "blog/$blogId?secret=06c51069-0171-4f23-bf8f-41c9cd86762d";
  static const String Packages = "package?secret=06c51069-0171-4f23-bf8f-41c9cd86762d";
  static const String settings = "setting?secret=06c51069-0171-4f23-bf8f-41c9cd86762d";



}

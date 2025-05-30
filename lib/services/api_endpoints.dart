class APIEndpoints {
  // Secret Key
  static const String _secretKey = "06c51069-0171-4f23-bf8f-41c9cd86762d";
    static const String baseurl="https://templatecookies.com/ott_clicknplay/public/api/";

  // Authentication
  static const String sendOtp = "send-otp";

  // Payment
  static const String stripePublishableKey = "pk_test_51R3woGCG37UV7MBEuZDyX1QGvAqSY4yxaBUduJyQRX18ucxrozR6ezq6CPSWF0VzJ0JfmlJYeO5KAuAfTYFl8HSp00zD5Er2RF";
  static const String paymentGateways = "paymentgateway-keys?secret=$_secretKey";
  static const String paymentHistory = "payment-history";
  static const String createOrderPackage = "create-order/package";
  static const String createOrderCoin = "create-order/coins";
  static const String createOrderPPV = "create-order/ppv";

  static  String invoice(int orderID) => baseurl+"invoice/$orderID?secret=$_secretKey";


  //WatchHisoty
  static const String showWatchHistoy = "watchhistory?secret=$_secretKey";
  static String addWatchHistory(String type, int id) =>
      "addwatchhistory/$type/$id?secret=$_secretKey";

  static String deleteWatchHistory(String type, int id) =>
      "delete_watchhistory/$type/$id?secret=$_secretKey";


  // Home
  static const String homeEndpoint = "home?secret=$_secretKey";

  // Wishlist & Comments
  static const String addComment = "addcomment?secret=$_secretKey";
  static const String deleteComment = "delete-comment?secret=$_secretKey";
  static const String addWishlist = "addwishlist?secret=$_secretKey";
  static const String showWishlist = "showwishlist";
  static const String removeMovie = "removemovie";
  static const String removeSeries = "removeseason";
  static const String removeVideo = "removevideo";
  static const String removeAudio = "removeaudio";
  static const String addWallet= "user-wallet";


  // TV Series
  static const String tvSeries = "tv-series?secret=$_secretKey&currency=INR";
  static String tvSeriesDetails(String slug) => "tvseries/$slug?secret=$_secretKey";

  // Movies & Videos
  static String movieDetails(String slug) => "movie/$slug?secret=$_secretKey";
  static String videoDetails(String videoSlug) => "video/$videoSlug?secret=$_secretKey";

  // Actor
  static String actorDetails(String actorSlug) => "actor/$actorSlug?secret=$_secretKey";
  static String directorDetails(String actorSlug) => "director/$actorSlug?secret=$_secretKey";

  // Genre & Audio
  static String moviesByGenre(String genreSlug) => "genre/$genreSlug?secret=$_secretKey";
  static String moviesByAudio(String audioSlug) => "language/$audioSlug?secret=$_secretKey";
  static String audioDetails(String audioSlug) => "audio/$audioSlug?secret=$_secretKey";

  // Search
  static String searchMovies(String searchTerm) => "search?secret=$_secretKey&searchTerm=$searchTerm";

  // Pages & Blogs
  static String pages(String pageName) => "pages/$pageName?secret=$_secretKey";
  static const String blogs = "blog";
  static String blogDetails(String slug) => "blog-detail/$slug?secret=$_secretKey";

  // Settings & Support
  static const String settings = "setting?secret=$_secretKey";
  static const String faq = "faq";
  static const String supportType = "support_type";
  static const String addSupport = "addsupport";

  // Packages
  static const String packages = "package?secret=$_secretKey";

}

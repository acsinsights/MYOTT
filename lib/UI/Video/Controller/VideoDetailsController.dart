import 'package:get/get.dart';
import 'package:myott/UI/Home/Model/videoModel.dart';
import 'package:myott/UI/Video/Model/VideoDetailsModel.dart';

import '../../../services/VideoService.dart';

class VideoDetailsController extends GetxController{
  final VideoService moviesService=VideoService();
  var videoDetails = Rxn<VideoDetailsModel>(null);
  var isLoading=false.obs;

  void fetchVideoDetails(String slug) async {
    try {
      isLoading(true);

      var fetchedVideoDetails = await moviesService.getVideosDetails(slug);

      if(fetchedVideoDetails!=null){
        videoDetails.value = fetchedVideoDetails;

      }

    } catch (e) {
      print("Error fetching movie details: $e");
    } finally {
      isLoading(false);
    }
  }

}
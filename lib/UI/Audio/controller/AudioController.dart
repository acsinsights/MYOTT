import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Audio/Model/AudioDeatilsResponseModel.dart';
import 'package:myott/UI/Audio/movies_by_audio.dart';
import 'package:myott/UI/Home/Model/HomeAudio.dart';
import 'package:myott/services/audioService.dart';

class AudioController extends GetxController {
  final AudioService audioService = AudioService();
  var selectedAudio = Rxn<HomeAudio>();
  var movies = <AuidoMovie>[].obs;
  var series = <AudioSeries>[].obs;
  var videos = <AudioVideo>[].obs;
  var audios = <Audio>[].obs;
  var isLoading = false.obs;


  void selectAudio(HomeAudio audio) {
    if (selectedAudio.value?.id != audio.id) {
      selectedAudio.value = audio;
      loadAudioData(audio.slug);
    }
    Get.to(() => MoviesByAudio());
  }


  Future<void> loadAudioData(String audioSlug) async {
    try {
      isLoading(true);
      var fetchedData = await audioService.fetchMandTAudio(audioSlug);

      if (fetchedData != null) {
        movies.assignAll(fetchedData.movies);
        series.assignAll(fetchedData.series);
        videos.assignAll(fetchedData.videos);
        audios.assignAll(fetchedData.audio);
        isLoading(false);
      } else {
        debugPrint("Error: No data received.");
      }
    } catch (e) {
      debugPrint("Error fetching audio data: $e");
    }finally{
      isLoading(false);

    }
  }
}

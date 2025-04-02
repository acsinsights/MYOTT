import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Audio/Model/MandTAudioModel.dart';
import 'package:myott/UI/Audio/movies_by_audio.dart';
import 'package:myott/UI/Home/Model/Audio_Model.dart';
import 'package:myott/services/PaymentGateway/audioService.dart';

class AudioController extends GetxController {
  var audioData = Rx<MandTAudioModel?>(null);
  final AudioService audioService = AudioService();
  var selectedAudio = Rxn<AudioModel>();
  var isLoading = false.obs;


  void selectAudio(AudioModel audio) {
    if (selectedAudio.value?.id != audio.id) {
      selectedAudio.value = audio;
      loadAudioData(audio.slug);
    }
    Get.to(() => MoviesByAudio());
  }
  Future<void> loadAudioData(String audioSlug) async {
    try {
      isLoading(true);
      MandTAudioModel? fetchedData = await audioService.fetchMandTAudio(audioSlug);

      if (fetchedData != null) {
        audioData.value = fetchedData;
        audioData.refresh();

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

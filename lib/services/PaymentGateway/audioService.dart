import 'package:myott/UI/Audio/Model/MandTAudioModel.dart';
import 'package:myott/services/api_endpoints.dart';

import '../api_service.dart';

class AudioService{
  ApiService apiService = ApiService();

  Future<MandTAudioModel?> fetchMandTAudio(String audioSlug) async {
    try {
      var response = await apiService.get(APIEndpoints.moviesByAudio(audioSlug));

      if (response != null && response.statusCode == 200) {
        var jsonData = response.data;
        return MandTAudioModel.fromJson(jsonData);
      } else {
        print("API Error: ${response?.statusCode}");
        return null;
      }
    } catch (e) {
      print("fetchMandTAudio Error: $e");
      return null;
    }
  }


}
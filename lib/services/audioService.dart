import 'package:myott/UI/Audio/Model/AudioDetialsResponseModel.dart';
import 'package:myott/UI/Audio/Model/LanguageDeatilsResponseModel.dart';
import 'package:myott/services/api_endpoints.dart';

import 'api_service.dart';

class AudioService{
  ApiService apiService = ApiService();

  Future<LanguageDetailsResponseModel?> fetchMandTAudio(String audioSlug) async {
    try {
      var response = await apiService.get(APIEndpoints.moviesByAudio(audioSlug));

      if (response != null && response.statusCode == 200) {
        var jsonData = response.data;
        return LanguageDetailsResponseModel.fromJson(jsonData);
      } else {
        print("API Error: ${response?.statusCode}");
        return null;
      }
    } catch (e) {
      print("fetchMandTAudio Error: $e");
      return null;
    }
  }

  Future<AudioDetailsResponseModel?> fetchAudioDetails(String slug) async {
    try {
      var response = await apiService.get(APIEndpoints.audioDetails(slug));

      if (response != null && response.statusCode == 200) {
        var jsonData = response.data;
        return AudioDetailsResponseModel.fromJson(jsonData);
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
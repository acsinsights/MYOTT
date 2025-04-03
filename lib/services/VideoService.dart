import 'package:dio/dio.dart';
import 'package:myott/UI/Home/Model/videoModel.dart';
import 'package:myott/UI/Video/Model/VideoDetailsModel.dart';
import 'package:myott/services/api_endpoints.dart';
import 'package:myott/services/api_service.dart';

class VideoService{
  ApiService apiService=ApiService();

  Future<VideoDetailsModel?> getVideosDetails(String videoSlug) async{
    try {
      final response = await apiService.get(APIEndpoints.videoDetails(videoSlug));
      if(response!.statusCode ==200){
        final data = response.data;
        return VideoDetailsModel.fromJson(data);
      }else{
        print("Error: ${response?.statusCode} - ${response?.statusMessage}");

      }
    } on DioException catch (e) {
      print("API Error: ${e.response?.statusCode} - ${e.message}");
    } catch (e) {
      print("Unexpected Error: $e");
    }
    return null;

  }

}
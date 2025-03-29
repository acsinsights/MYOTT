import '../UI/Actors/Model/ActorDetailsModel.dart';
import 'package:myott/services/api_endpoints.dart';
import 'package:myott/services/api_service.dart';

class ActorSerivce{
  ApiService _apiService;
  ActorSerivce(this._apiService);

  Future<ActorDetailsModel> fetchActorsDetails(actorSlug) async {
    try {
      final response= await _apiService.get("${APIEndpoints.actorDetails(actorSlug)}");
      if(response !=null || response?.statusCode==200){
        final data=response?.data;
        return ActorDetailsModel.fromJson(data);
      }else{
        throw Exception("Failed to fetch actor details");

      }
    } on Exception catch (e) {
      throw Exception("Error in fetchActorsDetails: $e");

    }
  }

}
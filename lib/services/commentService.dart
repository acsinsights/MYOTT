import 'package:dio/dio.dart';
import 'package:myott/services/api_endpoints.dart';
import 'package:myott/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentService{
  ApiService apiService=ApiService();

  Future<dynamic>sendComment(Map<String ,dynamic> comment)async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    final token=preferences.getString("access_token");
    Response? response=await apiService.post(APIEndpoints.addcomment,token: token,data: comment);
    return response;
  }

  Future<dynamic> replyComment(Map<String,dynamic> reply)async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    final token=preferences.getString("acess_token");
    Response? response=await apiService.post("endpoint",token: token,data: reply);
    return response;
  }
}
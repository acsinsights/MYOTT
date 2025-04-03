

import 'dart:convert';

SupportTypeModel supportTypeModelFromJson(String str) => SupportTypeModel.fromJson(json.decode(str));

String supportTypeModelToJson(SupportTypeModel data) => json.encode(data.toJson());

class SupportTypeModel {
  String message;
  List<SupportTypeData> data;

  SupportTypeModel({
    required this.message,
    required this.data,
  });

  factory SupportTypeModel.fromJson(Map<String, dynamic> json) => SupportTypeModel(
    message: json["message"]??"",
    data: json["data"]!=null? List<SupportTypeData>.from(json["data"].map((x) => SupportTypeData.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SupportTypeData {
  int id;
  String name;
  int status;


  SupportTypeData({
    required this.id,
    required this.name,
    required this.status,

  });

  factory SupportTypeData.fromJson(Map<String, dynamic> json) => SupportTypeData(
    id: json["id"]??0,
    name: json["name"]??"",
    status: json["status"]??0,

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,

  };
}

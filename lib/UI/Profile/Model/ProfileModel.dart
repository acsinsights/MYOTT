import 'dart:convert';



class ProfileModel {
  int? id;
  String name;
  String email;
  String mobile;


  ProfileModel({
     this.id,
    required this.name,
    required this.email,

    required this.mobile,

  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    email: json["email"] ?? "",

    mobile: json["mobile"] ?? "",

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "mobile": mobile,

  };
}

class UserModel {
  int id;
  String name;
  String email;
  String mobile;
  String role;
  String image;


  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.role,
    required this.image

  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    mobile: json["mobile"],
    image: json["image"],
    role: json["role"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "mobile": mobile,
    "role": role,

  };
}
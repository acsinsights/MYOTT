class UserModel {
  int id;
  String name;
  String email;
  String mobile;
  String role;
  String image;
  int? coins;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.role,
    required this.image,
    required this.coins
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"] ?? 0, // Default to 0 if null
    name: json["name"] ?? "Unknown", // Default to "Unknown" if null
    email: json["email"] ?? "No Email", // Default value
    mobile: json["mobile"] ?? "No Mobile", // Default value
    image: json["image"] ?? "", // Trim the image URL or path
    role: json["role"] ?? "User", // Default to "User"
    coins: json["coins"]??0
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "mobile": mobile,
    "role": role,
    "image": image,
  };
}

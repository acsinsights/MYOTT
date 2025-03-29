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
    required this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"] ?? 0, // Default to 0 if null
    name: json["name"] ?? "Unknown", // Default to "Unknown" if null
    email: json["email"] ?? "No Email", // Default value
    mobile: json["mobile"] ?? "No Mobile", // Default value
    image: (json["image"] ?? "https://i.pravatar.cc/300").trim(), // Trim the image URL or path
    role: json["role"] ?? "User", // Default to "User"
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

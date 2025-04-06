import 'dart:io';

class Profile {
  final int id;
  final String? image; // Store image URL if needed
  final String? name;
  final String? email;
  final String? mobile;
  final int? coins;

  Profile({required this.id, this.image, this.name, this.email, this.mobile,this.coins});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json["id"] ?? 0,
      image: json["image"], // API might return an image URL
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      mobile: json["mobile"] ?? "",
      coins: json["coins"]??0
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "mobile": mobile,
    };
  }
}

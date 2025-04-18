// To parse this JSON data, do
//
//     final settingModel = settingModelFromJson(jsonString);

import 'dart:convert';

SettingModel settingModelFromJson(String str) => SettingModel.fromJson(json.decode(str));


class SettingModel {
  GeneralSettings generalSettings;
  FooterSettings footerSettings;
  SeoSettings seoSettings;
  List<Language> languages;
  PlayerSettings playerSettings;
  ComingSoon comingSoon;
  coin coins;

  SettingModel({
    required this.generalSettings,
    required this.footerSettings,
    required this.seoSettings,
    required this.languages,
    required this.playerSettings,
    required this.comingSoon,
    required this.coins,
  });

  factory SettingModel.fromJson(Map<String, dynamic> json) => SettingModel(
    generalSettings: GeneralSettings.fromJson(json["general_settings"] ?? {}),
    footerSettings: FooterSettings.fromJson(json["footer_settings"] ?? {}),
    seoSettings: SeoSettings.fromJson(json["seo_settings"] ?? {}),
    languages: (json["languages"] as List<dynamic>?)
        ?.map((x) => Language.fromJson(x))
        .toList() ?? [],
    playerSettings: PlayerSettings.fromJson(json["player_settings"] ?? {}),
    comingSoon: ComingSoon.fromJson(json["coming_soon"]??{}),
      coins: coin.fromJson(json["coin"]??{})
  );

}

class coin {
  final int id;
  final int coins;

  coin({
    required this.id,
    required this.coins,
  });

  factory coin.fromJson(Map<String, dynamic> json) {
    return coin(
      id: json['id'] ?? 0,
      coins: json['coin'] ?? 0,
    );
  }
}


class ComingSoon {
  int id;
  String heading;
  String subHeading;
  String description;
  bool bgImageAvailable;
  String bgImage;
  String btnText;
  String ipAddress;
  Countdown countdown;
  DateTime createdAt;
  DateTime updatedAt;

  ComingSoon({
    required this.id,
    required this.heading,
    required this.subHeading,
    required this.description,
    required this.bgImageAvailable,
    required this.bgImage,
    required this.btnText,
    required this.ipAddress,
    required this.countdown,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ComingSoon.fromJson(Map<String, dynamic> json) => ComingSoon(
    id: json["id"] ?? 0,
    heading: json["heading"]?.toString() ?? "",
    subHeading: json["sub_heading"]?? "",
    description: json["description"]?? "",
    bgImageAvailable: json["bg_image_available"]?? "",
    bgImage: json["bg_image"]?? "",
    btnText: json["btn_text"]??"",
    ipAddress: json["ip_address"]??"",
    countdown: Countdown.fromJson(json["countdown"] ?? {}),
    createdAt: json["created_at"] != null ? DateTime.tryParse(json["created_at"]) ?? DateTime.now() : DateTime.now(),
    updatedAt: json["updated_at"] != null ? DateTime.tryParse(json["updated_at"]) ?? DateTime.now() : DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "heading": heading,
    "sub_heading": subHeading,
    "description": description,
    "bg_image_available": bgImageAvailable,
    "bg_image": bgImage,
    "btn_text": btnText,
    "ip_address": ipAddress,
    "countdown": countdown.toJson(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Countdown {
  int days;
  int hours;
  int minutes;
  int seconds;

  Countdown({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  factory Countdown.fromJson(Map<String, dynamic> json) => Countdown(
    days: json["days"] ?? 0,
    hours: json["hours"] ?? 0,
    minutes: json["minutes"]?? 0,
    seconds: json["seconds"]?? 0,
  );

  Map<String, dynamic> toJson() => {
    "days": days,
    "hours": hours,
    "minutes": minutes,
    "seconds": seconds,
  };
}

class FooterSettings {
  int id;
  String title;
  SocialLinks socialLinks;
  String description;
  String footerLogo;
  DateTime updatedAt;

  FooterSettings({
    required this.id,
    required this.title,
    required this.socialLinks,
    required this.description,
    required this.footerLogo,
    required this.updatedAt,
  });

  factory FooterSettings.fromJson(Map<String, dynamic> json) => FooterSettings(
    id: json["id"] ?? 0,
    title: json["title"]?? "",
    socialLinks: SocialLinks.fromJson(json["social_links"] ?? {}),
    description: json["description"]?? "",
    footerLogo: json["footer_logo"]?? "",
    updatedAt: json["updated_at"] != null ? DateTime.tryParse(json["updated_at"]) ?? DateTime.now() : DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "social_links": socialLinks.toJson(),
    "description": description,
    "footer_logo": footerLogo,
    "updated_at": updatedAt.toIso8601String(),
  };
}

class SocialLinks {
  String facebook;
  String linkedin;
  String twitter;
  String instagram;

  SocialLinks({
    required this.facebook,
    required this.linkedin,
    required this.twitter,
    required this.instagram,
  });

  factory SocialLinks.fromJson(Map<String, dynamic> json) => SocialLinks(
    facebook: json["facebook"]??"",
    linkedin: json["linkedin"]??"",
    twitter: json["twitter"]??"",
    instagram: json["instagram"]??"",
  );

  Map<String, dynamic> toJson() => {
    "facebook": facebook,
    "linkedin": linkedin,
    "twitter": twitter,
    "instagram": instagram,
  };
}

class GeneralSettings {
  int id;
  String contact;
  String email;
  String supportEmail;
  String address;
  String logo;
  int view;
  DateTime updatedAt;

  GeneralSettings({
    required this.id,
    required this.contact,
    required this.email,
    required this.supportEmail,
    required this.address,
    required this.view,
    required this.logo,
    required this.updatedAt,
  });

  factory GeneralSettings.fromJson(Map<String, dynamic> json) => GeneralSettings(
    id: json["id"]??0,
    contact: json["contact"]??"",
    email: json["email"]?? "",
    supportEmail: json["support_email"]??"",
    address: json["address"]??"",
    logo: json["logo"]??"",
    view: json["view"]??0,
    updatedAt: json["updated_at"] != null ? DateTime.tryParse(json["updated_at"]) ?? DateTime.now() : DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "contact": contact,
    "email": email,
    "support_email": supportEmail,
    "address": address,
    "logo": logo,
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Language {
  int id;
  String locale;
  String name;
  int status;
  String image;
  DateTime updatedAt;

  Language({
    required this.id,
    required this.locale,
    required this.name,
    required this.status,
    required this.image,
    required this.updatedAt,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    id: json["id"] ?? 0,
    locale: json["local"] ?? "",
    name: json["name"] ?? "",
    status: json["status"] ?? 0,
    image: json["image"] ?? "",
    updatedAt: json["updated_at"] != null ? DateTime.tryParse(json["updated_at"]) ?? DateTime.now() : DateTime.now(),
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "locale": locale,
    "name": name,
    "status": status,
    "image": image,
    "updated_at": updatedAt.toIso8601String(),
  };
}

class PlayerSettings {
  int id;
  int logoEnabled;
  String logoImage;
  int autoplay;
  DateTime updatedAt;

  PlayerSettings({
    required this.id,
    required this.logoEnabled,
    required this.logoImage,
    required this.autoplay,
    required this.updatedAt,
  });

  factory PlayerSettings.fromJson(Map<String, dynamic> json) => PlayerSettings(
    id: json["id"] ??0 ,
    logoEnabled: json["logo_enabled"]??0,
    logoImage: json["logo_image"]??"",
    autoplay: json["autoplay"]??0,
    updatedAt: json["updated_at"] != null ? DateTime.tryParse(json["updated_at"]) ?? DateTime.now() : DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "logo_enabled": logoEnabled,
    "logo_image": logoImage,
    "autoplay": autoplay,
    "updated_at": updatedAt.toIso8601String(),
  };
}

class SeoSettings {
  int id;
  String metaDescription;
  String metaKeywords;
  DateTime updatedAt;

  SeoSettings({
    required this.id,
    required this.metaDescription,
    required this.metaKeywords,
    required this.updatedAt,
  });

  factory SeoSettings.fromJson(Map<String, dynamic> json) => SeoSettings(
    id: json["id"]??0,
    metaDescription: json["meta_description"]??"",
    metaKeywords: json["meta_keywords"]??"",
    updatedAt: json["updated_at"] != null ? DateTime.tryParse(json["updated_at"]) ?? DateTime.now() : DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "meta_description": metaDescription,
    "meta_keywords": metaKeywords,
    "updated_at": updatedAt.toIso8601String(),
  };
}

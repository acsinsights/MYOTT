
import 'dart:convert';

SettingModel settingModelFromJson(String str) => SettingModel.fromJson(json.decode(str));

String settingModelToJson(SettingModel data) => json.encode(data.toJson());

class SettingModel {
  GeneralSettings generalSettings;
  FooterSettings footerSettings;
  SeoSettings seoSettings;
  List<Language> languages;
  PlayerSettings playerSettings;

  SettingModel({
    required this.generalSettings,
    required this.footerSettings,
    required this.seoSettings,
    required this.languages,
    required this.playerSettings,
  });

  factory SettingModel.fromJson(Map<String, dynamic> json) => SettingModel(
    generalSettings: GeneralSettings.fromJson(json["general_settings"]),
    footerSettings: FooterSettings.fromJson(json["footer_settings"]),
    seoSettings: SeoSettings.fromJson(json["seo_settings"]),
    languages: List<Language>.from(json["languages"].map((x) => Language.fromJson(x))),
    playerSettings: PlayerSettings.fromJson(json["player_settings"]),
  );

  Map<String, dynamic> toJson() => {
    "general_settings": generalSettings.toJson(),
    "footer_settings": footerSettings.toJson(),
    "seo_settings": seoSettings.toJson(),
    "languages": List<dynamic>.from(languages.map((x) => x.toJson())),
    "player_settings": playerSettings.toJson(),
  };
}

class FooterSettings {
  int id;
  String title;
  String fbUrl;
  String linkedinUrl;
  String twitterUrl;
  String instaUrl;
  String desc;
  String copyrightText;
  String image;
  String footerLogo;
  DateTime createdAt;
  DateTime updatedAt;

  FooterSettings({
    required this.id,
    required this.title,
    required this.fbUrl,
    required this.linkedinUrl,
    required this.twitterUrl,
    required this.instaUrl,
    required this.desc,
    required this.copyrightText,
    required this.image,
    required this.footerLogo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FooterSettings.fromJson(Map<String, dynamic> json) => FooterSettings(
    id: json["id"],
    title: json["title"],
    fbUrl: json["fb_url"],
    linkedinUrl: json["linkedin_url"],
    twitterUrl: json["twitter_url"],
    instaUrl: json["insta_url"],
    desc: json["desc"],
    copyrightText: json["copyright_text"],
    image: json["image"],
    footerLogo: json["footer_logo"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "fb_url": fbUrl,
    "linkedin_url": linkedinUrl,
    "twitter_url": twitterUrl,
    "insta_url": instaUrl,
    "desc": desc,
    "copyright_text": copyrightText,
    "image": image,
    "footer_logo": footerLogo,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class GeneralSettings {
  int id;
  String contact;
  String email;
  String supportEmail;
  String address;
  String iframeUrl;
  String promoText;
  String promoLink;
  String appStoreLink;
  String playStoreLink;
  String donationLink;
  String directLink;
  String logo;
  int logostatus;
  String faviconLogo;
  String preloaderLogo;
  String breadcrumbImg;
  int freeTrialDays;
  int preloaderEnableStatus;
  DateTime createdAt;
  DateTime updatedAt;

  GeneralSettings({
    required this.id,
    required this.contact,
    required this.email,
    required this.supportEmail,
    required this.address,
    required this.iframeUrl,
    required this.promoText,
    required this.promoLink,
    required this.appStoreLink,
    required this.playStoreLink,
    required this.donationLink,
    required this.directLink,
    required this.logo,
    required this.logostatus,
    required this.faviconLogo,
    required this.preloaderLogo,
    required this.breadcrumbImg,
    required this.freeTrialDays,
    required this.preloaderEnableStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GeneralSettings.fromJson(Map<String, dynamic> json) => GeneralSettings(
    id: json["id"],
    contact: json["contact"],
    email: json["email"],
    supportEmail: json["support_email"],
    address: json["address"],
    iframeUrl: json["iframe_url"],
    promoText: json["promo_text"],
    promoLink: json["promo_link"],
    appStoreLink: json["app_store_link"],
    playStoreLink: json["play_store_link"],
    donationLink: json["donation_link"],
    directLink: json["direct_link"],
    logo: json["logo"],
    logostatus: json["logostatus"],
    faviconLogo: json["favicon_logo"],
    preloaderLogo: json["preloader_logo"],
    breadcrumbImg: json["breadcrumb_img"],
    freeTrialDays: json["free_trial_days"],
    preloaderEnableStatus: json["preloader_enable_status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "contact": contact,
    "email": email,
    "support_email": supportEmail,
    "address": address,
    "iframe_url": iframeUrl,
    "promo_text": promoText,
    "promo_link": promoLink,
    "app_store_link": appStoreLink,
    "play_store_link": playStoreLink,
    "donation_link": donationLink,
    "direct_link": directLink,
    "logo": logo,
    "logostatus": logostatus,
    "favicon_logo": faviconLogo,
    "preloader_logo": preloaderLogo,
    "breadcrumb_img": breadcrumbImg,
    "free_trial_days": freeTrialDays,
    "preloader_enable_status": preloaderEnableStatus,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Language {
  int id;
  String local;
  String name;
  int status;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  Language({
    required this.id,
    required this.local,
    required this.name,
    required this.status,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    id: json["id"],
    local: json["local"],
    name: json["name"],
    status: json["status"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "local": local,
    "name": name,
    "status": status,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class PlayerSettings {
  int id;
  int playerLogo;
  String playerLogoImage;
  String logoPosition;
  int videoAutoPlay;
  int speedControl;
  int loopVideo;
  int chromeCast;
  int resumePlayback;
  int videoDownloadEnable;
  int watermark;
  int shuffle;
  String subtitleFontSize;
  String subtitleFontColor;
  DateTime createdAt;
  DateTime updatedAt;

  PlayerSettings({
    required this.id,
    required this.playerLogo,
    required this.playerLogoImage,
    required this.logoPosition,
    required this.videoAutoPlay,
    required this.speedControl,
    required this.loopVideo,
    required this.chromeCast,
    required this.resumePlayback,
    required this.videoDownloadEnable,
    required this.watermark,
    required this.shuffle,
    required this.subtitleFontSize,
    required this.subtitleFontColor,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PlayerSettings.fromJson(Map<String, dynamic> json) => PlayerSettings(
    id: json["id"],
    playerLogo: json["player_logo"],
    playerLogoImage: json["player_logo_image"],
    logoPosition: json["logo_position"],
    videoAutoPlay: json["video_auto_play"],
    speedControl: json["speed_control"],
    loopVideo: json["loop_video"],
    chromeCast: json["chrome_cast"],
    resumePlayback: json["resume_playback"],
    videoDownloadEnable: json["video_download_enable"],
    watermark: json["watermark"],
    shuffle: json["shuffle"],
    subtitleFontSize: json["subtitle_font_size"],
    subtitleFontColor: json["subtitle_font_color"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "player_logo": playerLogo,
    "player_logo_image": playerLogoImage,
    "logo_position": logoPosition,
    "video_auto_play": videoAutoPlay,
    "speed_control": speedControl,
    "loop_video": loopVideo,
    "chrome_cast": chromeCast,
    "resume_playback": resumePlayback,
    "video_download_enable": videoDownloadEnable,
    "watermark": watermark,
    "shuffle": shuffle,
    "subtitle_font_size": subtitleFontSize,
    "subtitle_font_color": subtitleFontColor,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class SeoSettings {
  int id;
  String metaDataDesc;
  String metaDataKeyword;
  DateTime createdAt;
  DateTime updatedAt;

  SeoSettings({
    required this.id,
    required this.metaDataDesc,
    required this.metaDataKeyword,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SeoSettings.fromJson(Map<String, dynamic> json) => SeoSettings(
    id: json["id"],
    metaDataDesc: json["meta_data_desc"],
    metaDataKeyword: json["meta_data_keyword"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "meta_data_desc": metaDataDesc,
    "meta_data_keyword": metaDataKeyword,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

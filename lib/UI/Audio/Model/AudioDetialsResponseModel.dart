class AudioDetailsResponseModel {
  int? id;
  String? audioUploadType;
  String? audioUploadUrl;
  dynamic audioUploadFiles;
  String? name;
  String? slug;
  String? thumbnailImg;
  int? audioLanguage;
  String? maturity;
  String? releaseYear;
  int? views;
  int? fakeViews;
  String? durationTime;
  String? description;
  dynamic scheduleDate;
  dynamic scheduleTime;
  int? status;
  String? type;
  Cast? cast;

  AudioDetailsResponseModel({
    this.id,
    this.audioUploadType,
    this.audioUploadUrl,
    this.audioUploadFiles,
    this.name,
    this.slug,
    this.thumbnailImg,
    this.audioLanguage,
    this.maturity,
    this.releaseYear,
    this.views,
    this.fakeViews,
    this.durationTime,
    this.description,
    this.scheduleDate,
    this.scheduleTime,
    this.status,
    this.type,
    this.cast,
  });

  factory AudioDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return AudioDetailsResponseModel(
      id: json['id'],
      audioUploadType: json['audio_upload_type'],
      audioUploadUrl: json['audio_upload_url'],
      audioUploadFiles: json['audio_upload_files'],
      name: json['name'],
      slug: json['slug'],
      thumbnailImg: json['thumbnail_img'],
      audioLanguage: json['audio_language'],
      maturity: json['maturity'],
      releaseYear: json['release_year'],
      views: json['views'],
      fakeViews: json['fake_views'],
      durationTime: json['duration_time'],
      description: json['description'],
      scheduleDate: json['schedule_date'],
      scheduleTime: json['schedule_time'],
      status: json['status'],
      type: json['type'],
      cast: json['cast'] != null ? Cast.fromJson(json['cast']) : null,
    );
  }
}

class Cast {
  List<Person>? actors;
  List<Person>? directors;
  List<Genre>? genres;

  Cast({
    this.actors,
    this.directors,
    this.genres,
  });

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      actors: json['actors'] != null
          ? List<Person>.from(json['actors'].map((x) => Person.fromJson(x)))
          : null,
      directors: json['directors'] != null
          ? List<Person>.from(json['directors'].map((x) => Person.fromJson(x)))
          : null,
      genres: json['genres'] != null
          ? List<Genre>.from(json['genres'].map((x) => Genre.fromJson(x)))
          : null,
    );
  }
}

class Person {
  int? id;
  String? name;
  String? image;

  Person({
    this.id,
    this.name,
    this.image,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}

class Genre {
  int? id;
  String? name;
  String? image;

  Genre({
    this.id,
    this.name,
    this.image,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
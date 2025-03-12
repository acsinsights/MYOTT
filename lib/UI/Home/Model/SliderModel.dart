


import 'ContentModel.dart';

class SliderItemModel {
  final int id;
  final ContentModel content;

  SliderItemModel({
    required this.id,
    required this.content,
  });

  factory SliderItemModel.fromJson(Map<String, dynamic> json) {
    return SliderItemModel(
      id: json['id'],
      content: ContentModel.fromJson(json['content']),
    );
  }
  //
  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "content": content.toJson(),
  // };
}


import 'package:json_annotation/json_annotation.dart';

part 'image_model.g.dart';

// The API returns a list of images directly, not wrapped in an object
// So we'll work with List<APIImage> directly in our service

@JsonSerializable()
class APIImage {
  int id;
  String title;
  String url;
  String thumbnailUrl;

  APIImage({
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory APIImage.fromJson(Map<String, dynamic> json) =>
      _$APIImageFromJson(json);

  Map<String, dynamic> toJson() => _$APIImageToJson(this);
}

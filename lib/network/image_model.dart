import 'package:json_annotation/json_annotation.dart';

part 'image_model.g.dart';

@JsonSerializable()
class APIImageQuery {
  factory APIImageQuery.fromJson(Map<String, dynamic> json) =>
      _$APIImageQueryFromJson(json);

  Map<String, dynamic> toJson() => _$APIImageQueryToJson(this);
  int page;
  @JsonKey(name: 'page_count')
  int pageCcount;
  @JsonKey(name: 'total_counts')
  int totalCcounts;
  int status;
  @JsonKey(name: 'data')
  List<APIImage> images;

  APIImageQuery({
    required this.page,
    required this.pageCcount,
    required this.totalCcounts,
    required this.status,
    required this.images,
  });
}

@JsonSerializable()
class APIImage {
  @JsonKey(name: '_id')
  String id;
  String author;
  String category;
  String createdAt;
  String desc;
  List<String> images;
  int likeCounts;
  String publishedAt;
  int stars;
  String title;
  String type;
  String url;
  int views;

  APIImage({
    required this.id,
    required this.author,
    required this.category,
    required this.createdAt,
    required this.desc,
    required this.images,
    required this.likeCounts,
    required this.publishedAt,
    required this.stars,
    required this.title,
    required this.type,
    required this.url,
    required this.views,
  });

  factory APIImage.fromJson(Map<String, dynamic> json) =>
      _$APIImageFromJson(json);

  Map<String, dynamic> toJson() => _$APIImageToJson(this);
}

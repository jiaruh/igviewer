// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIImageQuery _$APIImageQueryFromJson(Map<String, dynamic> json) {
  return APIImageQuery(
    page: json['page'] as int,
    pageCcount: json['page_count'] as int,
    totalCcounts: json['total_counts'] as int,
    status: json['status'] as int,
    images: (json['data'] as List<dynamic>)
        .map((e) => APIImage.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$APIImageQueryToJson(APIImageQuery instance) =>
    <String, dynamic>{
      'page': instance.page,
      'page_count': instance.pageCcount,
      'total_counts': instance.totalCcounts,
      'status': instance.status,
      'data': instance.images,
    };

APIImage _$APIImageFromJson(Map<String, dynamic> json) {
  return APIImage(
    id: json['_id'] as String,
    author: json['author'] as String,
    category: json['category'] as String,
    createdAt: json['createdAt'] as String,
    desc: json['desc'] as String,
    images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    likeCounts: json['likeCounts'] as int,
    publishedAt: json['publishedAt'] as String,
    stars: json['stars'] as int,
    title: json['title'] as String,
    type: json['type'] as String,
    url: json['url'] as String,
    views: json['views'] as int,
  );
}

Map<String, dynamic> _$APIImageToJson(APIImage instance) => <String, dynamic>{
      '_id': instance.id,
      'author': instance.author,
      'category': instance.category,
      'createdAt': instance.createdAt,
      'desc': instance.desc,
      'images': instance.images,
      'likeCounts': instance.likeCounts,
      'publishedAt': instance.publishedAt,
      'stars': instance.stars,
      'title': instance.title,
      'type': instance.type,
      'url': instance.url,
      'views': instance.views,
    };

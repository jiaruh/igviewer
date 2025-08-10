import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';

import 'image_model.dart';

class CustomJsonConverter extends JsonConverter {
  @override
  FutureOr<Response<BodyType>> convertResponse<BodyType, InnerType>(
    Response response,
  ) async {
    try {
      final dynamic body = response.body;
      
      if (body is String) {
        // Parse the JSON string first
        final dynamic jsonBody = json.decode(body);
        
        if (jsonBody is List) {
          // Handle list responses (like our photos endpoint)
          final List<APIImage> images = jsonBody
              .map((item) => APIImage.fromJson(item as Map<String, dynamic>))
              .toList();
          return response.copyWith<BodyType>(body: images as BodyType);
        } else if (jsonBody is Map<String, dynamic>) {
          // Handle map responses
          final APIImage image = APIImage.fromJson(jsonBody);
          return response.copyWith<BodyType>(body: image as BodyType);
        }
      } else if (body is List) {
        // Handle list responses (like our photos endpoint)
        final List<APIImage> images = body
            .map((item) => APIImage.fromJson(item as Map<String, dynamic>))
            .toList();
        return response.copyWith<BodyType>(body: images as BodyType);
      } else if (body is Map<String, dynamic>) {
        // Handle map responses
        final APIImage image = APIImage.fromJson(body);
        return response.copyWith<BodyType>(body: image as BodyType);
      }
      
      return response.copyWith<BodyType>(body: body as BodyType);
    } catch (e) {
      print('Error converting response: $e');
      rethrow;
    }
  }
}

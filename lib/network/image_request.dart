import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:chopper/chopper.dart';
import 'package:igviewer/network/request_convert.dart';
import 'image_model.dart';

part 'image_request.chopper.dart';

const String apiUrl = 'https://jsonplaceholder.typicode.com/';

@ChopperApi()
abstract class ImageService extends ChopperService {
  @Get(path: 'photos')
  Future<Response<List<APIImage>>> queryImages();
  
  // Custom method to get images with working picsum.photos URLs
  Future<Response<List<APIImage>>> getWorkingImages() async {
    // Generate mock data with working picsum.photos URLs
    final List<APIImage> mockImages = List.generate(20, (index) {
      final imageId = 100 + index;
      return APIImage(
        id: imageId,
        title: 'Beautiful Image ${index + 1}',
        url: 'https://picsum.photos/600/400?random=$imageId',
        thumbnailUrl: 'https://picsum.photos/150/150?random=$imageId',
      );
    });
    
    return Response(http.Response('', 200), mockImages);
  }

  static ImageService create() {
    final httpClient = http.Client();
    
    final client = ChopperClient(
      baseUrl: Uri.parse(apiUrl),
      interceptors: [
        HttpLoggingInterceptor(),
      ],
      converter: CustomJsonConverter(),
      errorConverter: JsonConverter(),
      services: [
        _$ImageService(),
      ],
      client: httpClient,
    );
    return _$ImageService(client);
  }
}

Request _addQuery(Request req) {
  final params = Map<String, dynamic>.from(req.parameters);
  return req.copyWith(parameters: params);
}

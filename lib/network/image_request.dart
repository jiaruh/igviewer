import 'dart:io';

import 'package:http/io_client.dart' as http;
import 'package:chopper/chopper.dart';
import 'package:ioreader/network/request_convert.dart';
import 'image_model.dart';
part 'image_request.chopper.dart';

const String apiUrl = 'https://gank.io/api/v2/';

@ChopperApi()
abstract class ImageService extends ChopperService {
  @Get(path: 'data/category/{category}/type/{type}/page/{page}/count/{count}')
  Future<Response<APIImageQuery>> queryImages(@Path() String category,
      @Path() String type, @Path() int page, @Path() int count);

  static ImageService create() {
    final client = ChopperClient(
      baseUrl: apiUrl,
      interceptors: [_addQuery, HttpLoggingInterceptor()],
      converter: ImageModelConverter(),
      errorConverter: const JsonConverter(),
      services: [
        _$ImageService(),
      ],
      client: http.IOClient(HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true),
    );
    return _$ImageService(client);
  }
}

Request _addQuery(Request req) {
  final params = Map<String, dynamic>.from(req.parameters);
  return req.copyWith(parameters: params);
}

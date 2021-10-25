import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';

import 'image_model.dart';

class ImageModelConverter implements Converter {
  ImageModelConverter() {
    print("ImageModelConverter init");
  }

  // doesn't called..
  @override
  Request convertRequest(Request request) {
    return request;
    final params = request.parameters;
    var subpath =
        'category/${params["category"]}/type/${params["type"]}/page/${params["page"]}/count/${params["count"]}';
    return request.copyWith(url: subpath, parameters: null);
  }

  @override
  FutureOr<Response<BodyType>> convertResponse<BodyType, InnerType>(
      Response response) {
    var body = response.body;
    final mapData = json.decode(body);
    final query = APIImageQuery.fromJson(mapData);
    return response.copyWith<BodyType>(body: query as BodyType);
  }
}

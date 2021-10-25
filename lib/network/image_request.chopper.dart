// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_request.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ImageService extends ImageService {
  _$ImageService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ImageService;

  @override
  Future<Response<APIImageQuery>> queryImages(
      String category, String type, int page, int count) {
    final $url = 'data/category/$category/type/$type/page/$page/count/$count';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<APIImageQuery, APIImageQuery>($request);
  }
}

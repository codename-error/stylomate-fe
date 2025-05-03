// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wardrobe.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$WardrobeService extends WardrobeService {
  _$WardrobeService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = WardrobeService;

  @override
  Future<Response<dynamic>> getWardrobes() {
    final Uri $url = Uri.parse('/wardrobe');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addWardrobe(String data) {
    final Uri $url = Uri.parse('/wardrobe/create');
    final $body = data;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>(
      $request,
      requestConverter: FormUrlEncodedConverter.requestFactory,
    );
  }

  @override
  Future<Response<dynamic>> getRecommendation(Map<String, dynamic> data) {
    final Uri $url = Uri.parse('/recomendation');
    final $body = data;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }
}

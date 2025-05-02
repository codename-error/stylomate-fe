import 'package:chopper/chopper.dart';

part 'test.chopper.dart';

@ChopperApi()
abstract class TestService extends ChopperService {
  static TestService create([ChopperClient? client]) {
    final newClient = client ?? ChopperClient(
      baseUrl: Uri.parse('https://a977-202-158-77-58.ngrok-free.app/v2'),
      services: [_$TestService()],
      converter: JsonConverter(),
      interceptors: [HttpLoggingInterceptor()],
    );
    return _$TestService(newClient);
  }

  @Get(path: '/ping')
  Future<Response<dynamic>> getPing();
}

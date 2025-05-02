import 'package:chopper/chopper.dart';
import 'package:stylomate/services/base_network.dart';

part 'test.chopper.dart';

@ChopperApi()
abstract class TestService extends ChopperService {
  static TestService create([ChopperClient? client]) {
    final newClient = client ?? ChopperClient(
      baseUrl: Uri.parse(BaseNetwork.baseUrl),
      services: [_$TestService()],
      converter: JsonConverter(),
      interceptors: [HttpLoggingInterceptor()],
    );
    return _$TestService(newClient);
  }

  @Get(path: '/ping')
  Future<Response<dynamic>> getPing();
}

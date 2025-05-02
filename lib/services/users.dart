import 'package:chopper/chopper.dart';
import 'package:stylomate/services/base_network.dart';

part 'users.chopper.dart';

@ChopperApi()
abstract class UsersService extends ChopperService {
  static UsersService create([ChopperClient? client]) {
    final newClient = client ?? ChopperClient(
      baseUrl: Uri.parse(BaseNetwork.baseUrl),
      services: [_$UsersService()],
      converter: JsonConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
        (Request request) async {
          return request.copyWith(
            headers: {
              ...request.headers,
              'Authorization': 'Bearer ${BaseNetwork.sampleToken}',
            },
          );
        }
      ],
    );
    return _$UsersService(newClient);
  }

  @Get(path: '/pong')
  Future<Response<dynamic>> getUser();
}

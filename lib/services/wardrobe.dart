import 'package:chopper/chopper.dart';
import 'package:stylomate/services/base_network.dart';

part 'wardrobe.chopper.dart';

@ChopperApi()
abstract class WardrobeService extends ChopperService {
  static WardrobeService create([ChopperClient? client]) {
    final newClient = client ?? ChopperClient(
      baseUrl: Uri.parse(BaseNetwork.baseUrl),
      services: [_$WardrobeService()],
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
    return _$WardrobeService(newClient);
  }

  @Get(path: '/wardrobe')
  Future<Response<dynamic>> getWardrobes();

  @Post(path: '/wardrobe/create')
  Future<Response<dynamic>> addWardrobe(@Body() Map<String, dynamic> body);
}

import 'package:dio/dio.dart';
import 'package:localstorage/localstorage.dart';

class TokenInterceptor extends InterceptorsWrapper {
  @override
  Future<RequestOptions> onRequest(RequestOptions options) async {
    var storage = LocalStorage('Token');
    final token = storage.getItem('Token');

    if (token == null) {
      throw Exception;
    }

    options.headers['Authorization'] = 'Bearer $token';

    return options;
  }

  @override
  Future<DioError> onError(DioError err) async {
    if (err.response?.statusCode == 401) {
      // Handle refresh token here
    }

    return err;
  }
}

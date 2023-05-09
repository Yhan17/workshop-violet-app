import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import '../config/env.dart';

class BackendHttpClient extends DioMixin {
  @override
  HttpClientAdapter get httpClientAdapter => IOHttpClientAdapter();

  @override
  BaseOptions get options => BaseOptions(
        baseUrl: Env.backendUrl,
        headers: {
          'Content-Type': 'application/json',
        },
        connectTimeout: const Duration(seconds: 10), // 10 segundos
        receiveTimeout: const Duration(seconds: 10), // 10 segundos
      );
}

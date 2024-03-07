import 'package:dio/dio.dart';
import 'package:trafic_gesture/shared/infrastructure/either.dart';
import 'package:trafic_gesture/shared/infrastructure/exceptions/exception_handler_mixin.dart';
import 'package:trafic_gesture/shared/infrastructure/exceptions/http_exception.dart';
import 'package:trafic_gesture/shared/infrastructure/network_service.dart';
import 'package:trafic_gesture/shared/infrastructure/response.dart' as response;

class DioNetworkService extends NetworkService with ExceptionHandlerMixin {
  final Dio dio;
  // ignore: non_constant_identifier_names
  Duration DEFAULT_TIMEOUT = const Duration(seconds: 30);
  DioNetworkService(this.dio) {
    // this throws error while running test

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  BaseOptions get dioBaseOptions => BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
        receiveTimeout: DEFAULT_TIMEOUT,
      );
  @override
  String get baseUrl => AppConfigs.baseUrl;

  @override
  Map<String, Object> get headers => {
        'accept': 'application/json',
        'content-type': 'application/json',
      };
  @override
  Map<String, dynamic>? updateHeader(Map<String, dynamic> data) {
    final header = {...data, ...headers};
    // if (!kTestMode) {
    dio.options.headers = header;
    // }
    return header;
  }

  @override
  Future<Either<AppException, response.Response>> post(String endpoint,
      {Map<String, dynamic>? data}) {
    String finalEndpoint = '${baseUrl}${endpoint}';
    print(finalEndpoint);

    final res = handleException(
      () => dio.post(
        finalEndpoint,
        data: data,
      ),
      endpoint: endpoint,
    );
    return res;
  }

  @override
  Future<Either<AppException, response.Response>> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) {
    final res = handleException(
      () => dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            // "Cookie": "x-sultan-token=${AuthRepository.currentUser.token}"
          },
        ),
      ),
      endpoint: endpoint,
    );
    return res;
  }

  @override
  Future<Either<AppException, response.Response>> patch(String endpoint,
      {Map<String, dynamic>? queryParameters}) {
    final res = handleException(
      () => dio.patch(
        endpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            // "Cookie": "x-sultan-token=${AuthRepository.currentUser.token}"
          },
        ),
      ),
      endpoint: endpoint,
    );
    return res;
  }

  @override
  Future<Either<AppException, response.Response>> delete(String endpoint,
      {Map<String, dynamic>? queryParameters}) {
    final res = handleException(
      () => dio.delete(
        endpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            // "Cookie": "x-sultan-token=${AuthRepository.currentUser.token}"
          },
        ),
      ),
      endpoint: endpoint,
    );
    return res;
  }

  @override
  Future<Either<AppException, response.Response>> put(String endpoint,
      {Map<String, dynamic>? queryParameters}) {
    final res = handleException(
      () => dio.put(
        endpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            // "Cookie": "x-sultan-token=${AuthRepository.currentUser.token}"
          },
        ),
      ),
      endpoint: endpoint,
    );
    return res;
  }
}

class AppConfigs {
  static String baseUrl = 'http://localhost:3000/api/auth';
}

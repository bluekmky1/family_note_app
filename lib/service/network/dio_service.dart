import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final Provider<Dio> dioService = Provider<Dio>(
  (Ref ref) => DioClient.dio
    ..interceptors.addAll(<Interceptor>[
      if (kDebugMode)
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
    ]),
);

class DioClient {
  static const String baseUrl = 'https://apis.data.go.kr/1613000/';

  factory DioClient() => DioClient._();
  DioClient._();

  static final Dio _dio = Dio();

  static Dio get dio => _dio
    ..options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
      sendTimeout: const Duration(milliseconds: 30 * 1000),
      // contentType을 명시적으로 지정해줘야 합니다.
      // https://github.com/cfug/dio/issues/1653
      contentType: Headers.jsonContentType,
    );
}

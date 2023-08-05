import 'package:dio/dio.dart';
import 'package:zendy/helpers/constants.dart';
import 'package:zendy/helpers/print_log.dart';
import 'package:zendy/services/auth_service.dart';

Dio getDioClient() {
  final dio = Dio(
    BaseOptions(
      baseUrl: apiBaseUrl,
      receiveDataWhenStatusError: true,
      headers: {
        "custom-country-header": "NG",
        //   "Authorization": "Bearer $apiKey",
      },
    ),
  );

  dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
    options.extra['requestStartTime'] = DateTime.now().millisecondsSinceEpoch;
    printLog('Request URL:', '${options.baseUrl}${options.path}');
    return handler.next(options);
  }, onResponse: (response, handler) {
    final requestStartTime = response.requestOptions.extra['requestStartTime'];
    final endTime = DateTime.now().millisecondsSinceEpoch;
    final duration = endTime - requestStartTime;
    printLog(
      'Response URL:',
      '${response.requestOptions.baseUrl}${response.requestOptions.path}',
    );
    printLog('Response Time:', '${duration}ms');
    return handler.next(response);
  }, onError: (DioException e, handler) {
    printLog('Error: interceptors', '${e.message}');
    return handler.next(e);
  }));

  return dio;
}

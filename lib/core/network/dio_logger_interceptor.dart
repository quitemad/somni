import 'package:dio/dio.dart';
import 'app_logger.dart';

class DioLoggerInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) {
    appLogger.t('➡️ REQUEST\n'
        'URL: ${options.uri}\n'
        'Method: ${options.method}\n'
        'Headers: ${options.headers}\n');

    if (options.data != null) {
      appLogger.i('Body: ${options.data}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
      Response response,
      ResponseInterceptorHandler handler,
      ) {
    appLogger.i('✅ RESPONSE\n'
        'URL: ${response.requestOptions.uri}\n'
        'Status Code: ${response.statusCode}\n'
        'Data: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) {
    appLogger.e('❌ ERROR\n'
        'URL: ${err.requestOptions.uri}\n'
    'Status Code: ${err.response?.statusCode}\n'
        'Message: ${err.message}');

    if (err.response?.data != null) {
      appLogger.e('Error Data: ${err.response?.data}');
    }
    super.onError(err, handler);
  }
}

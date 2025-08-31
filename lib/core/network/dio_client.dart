import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../constants/app_constants.dart';

class DioClient {
  late final Dio _dio;
  final Logger _logger;

  DioClient(this._logger) {
    _dio = Dio();
    _configureDio();
  }

  Dio get dio => _dio;

  void _configureDio() {
    // Configuración básica
    _dio.options.baseUrl = AppConstants.baseUrl + AppConstants.apiVersion;
    _dio.options.connectTimeout = AppConstants.connectionTimeout;
    _dio.options.receiveTimeout = AppConstants.receiveTimeout;
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // Interceptores
    _dio.interceptors.addAll([
      _LoggingInterceptor(_logger),
      _AuthInterceptor(),
      _ErrorInterceptor(_logger),
    ]);
  }

  // Método para agregar token de autenticación
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // Método para remover token de autenticación
  void removeAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  // Método para actualizar base URL
  void updateBaseUrl(String newBaseUrl) {
    _dio.options.baseUrl = newBaseUrl;
  }
}

class _LoggingInterceptor extends Interceptor {
  final Logger _logger;

  _LoggingInterceptor(this._logger);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.i('REQUEST[${options.method}] => PATH: ${options.path}');
    _logger.d('Headers: ${options.headers}');
    _logger.d('Data: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.i(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    _logger.d('Data: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    _logger.e('Message: ${err.message}');
    _logger.e('Data: ${err.response?.data}');
    super.onError(err, handler);
  }
}

class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Aquí se puede agregar lógica para renovar tokens automáticamente
    // o manejar casos especiales de autenticación
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Token expirado o inválido
      // Aquí se puede implementar lógica para renovar el token
      // o redirigir al login
    }
    super.onError(err, handler);
  }
}

class _ErrorInterceptor extends Interceptor {
  final Logger _logger;

  _ErrorInterceptor(this._logger);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Manejo centralizado de errores
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        _logger.e('Timeout error: ${err.message}');
        break;
      case DioExceptionType.badResponse:
        _logger.e(
          'Bad response: ${err.response?.statusCode} - ${err.response?.statusMessage}',
        );
        break;
      case DioExceptionType.cancel:
        _logger.w('Request cancelled');
        break;
      case DioExceptionType.connectionError:
        _logger.e('Connection error: ${err.message}');
        break;
      default:
        _logger.e('Unknown error: ${err.message}');
    }
    super.onError(err, handler);
  }
}

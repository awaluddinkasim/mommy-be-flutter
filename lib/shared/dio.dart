import 'package:dio/dio.dart';
import 'package:mommy_be/shared/constants.dart';

class Request {
  static final _dio = Dio()
    ..options.baseUrl = '${Constants.baseUrl}/api'
    ..options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

  static Future<dynamic> get(
    String url, {
    Map<String, dynamic>? headers,
  }) async {
    try {
      final Response response =
          await _dio.get(url, options: Options(headers: headers));
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  static Future<dynamic> post(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  static Future<dynamic> put(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  static Future<dynamic> delete(
    String url, {
    Map<String, dynamic>? headers,
  }) async {
    try {
      final Response response =
          await _dio.delete(url, options: Options(headers: headers));
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  static String _handleError(DioException error) {
    String errorDescription = "";
    print(error.type);
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        errorDescription = "Koneksi timeout";
        break;
      case DioExceptionType.badResponse:
        errorDescription = "${error.response?.data['message']}";
        break;
      case DioExceptionType.cancel:
        errorDescription = "Request ke API server dibatalkan";
        break;
      default:
        errorDescription = "Terjadi kesalahan yang tidak diketahui";
        break;
    }
    return errorDescription;
  }
}

import 'dart:io';

import 'package:chat_chit_flutter/core/app_constants.dart';
import 'package:dio/dio.dart';

class ApiClientService {
  ApiClientService() {
    _dio.options = BaseOptions(
      baseUrl: AppConstants.apiBaseUrl,
      headers: {'Content-Type': 'application/json'},
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );
    _dio.interceptors.add(_ErrorInterceptor());
  }

  final Dio _dio = Dio();

  Future<T> post<T>({
    required String endpoint,
    required Map<String, dynamic> body,
    T Function(Map<String, dynamic>)? fromJson,
    String? key,
    Map<String, String>? queryParams,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      endpoint,
      data: body,
      queryParameters: queryParams,
    );
    final data = key != null ? response.data![key] : response.data;
    return fromJson != null ? fromJson(data as Map<String, dynamic>) : data as T;
  }

  Future<String> postFile({
    required String endpoint,
    required File fileToUpload,
    String? key,
  }) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        fileToUpload.path,
        filename: fileToUpload.path.split('/').last,
      ),
    });

    final response = await _dio.post<Map<String, dynamic>>(
      endpoint,
      data: formData,
      options: Options(headers: {'Accept': 'application/json'}),
    );

    final data = key != null ? response.data![key] : response.data;
    return data as String;
  }

  Future<T> get<T>({
    required String endpoint,
    Map<String, String>? queryParams,
    T Function(Map<String, dynamic>)? fromJson,
    String? key,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      endpoint,
      queryParameters: queryParams,
    );
    final data = key != null ? response.data![key] : response.data;
    return fromJson != null ? fromJson(data as Map<String, dynamic>) : data as T;
  }
}

class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final message = err.response?.data is Map
        ? (err.response!.data as Map)['message'] ?? err.message
        : err.message ?? 'Unexpected error';
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: Exception(message),
        message: message.toString(),
      ),
    );
  }
}

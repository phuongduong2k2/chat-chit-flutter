import 'dart:convert';
import 'dart:io';

import 'package:chat_chit_flutter/extensions/exception_extension.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

const Map<String, String> defaultHeaders = {"Content-Type": 'application/json'};

class ApiClientService {
  static String authority = 'localhost:8082';
  static String baseUrl = 'http://$authority';
  final Dio _dio = Dio();

  Future<T> post<T>({
    required String endpoint,
    required Map<String, dynamic> body,
    T Function(Map<String, dynamic>)? fromJson,
    String? key,
    Map<String, String>? params,
  }) async {
    try {
      final url = Uri.http(authority, endpoint, params);
      final response = await http.post(
        url,
        headers: defaultHeaders,
        body: jsonEncode(body),
      );

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final dynamic res = key != null ? jsonResponse[key] : jsonResponse;
        return fromJson != null ? fromJson(res) : res;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } on Exception catch (error) {
      throw Exception(error.cleanMessage);
    }
  }

  Future<String> postFile({
    required String endpoint,
    required File fileToUpload,
    String? key,
  }) async {
    final url = "$baseUrl$endpoint";
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          fileToUpload.path,
          filename: fileToUpload.path.split('/').last,
        ),
      });

      Response response = await _dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return key != null ? response.data[key] : response.data;
      } else {
        throw Exception("Upload failed with status: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception("Server error data: ${e.response?.data}");
      }
      throw Exception("Dio Error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected Error: $e");
    }
  }

  Future<T> get<T>({
    required String endpoint,
    Map<String, String>? params,
    T Function(Map<String, dynamic> json)? fromJson,
    String? key,
  }) async {
    try {
      final uri = Uri.http(authority, endpoint, params);
      final response = await http.get(uri, headers: defaultHeaders);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseMap = jsonDecode(response.body);
        final res = key != null ? responseMap[key] : responseMap;
        return res;
      } else {
        throw Exception(response.body);
      }
    } on Exception catch (ex) {
      throw Exception(ex.cleanMessage);
    }
  }
}

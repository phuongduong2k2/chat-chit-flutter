import 'dart:convert';
import 'dart:io';

import 'package:chat_chit_flutter/extensions/exception_extension.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

const Map<String, String> defaultHeaders = {"Content-Type": 'application/json'};

class ApiClientService {
  static String baseUrl = 'http://localhost:8082';
  final Dio _dio = Dio();

  Future<T> post<T>({
    required String endpoint,
    required Map<String, dynamic> body,
    T Function(Map<String, dynamic>)? fromJson,
    String? key,
  }) async {
    try {
      final url = Uri.parse("$baseUrl/$endpoint");
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

  Future<String> postImage({
    required String endpoint,
    required File fileToUpload,
    String? key,
  }) async {
    final url = "http://localhost:8082/api/v1/upload/";
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
}

import 'dart:convert';

import 'package:chat_chit_flutter/extensions/exception_extension.dart';
import 'package:http/http.dart' as http;

class ApiClientService {
  static String baseUrl = 'http://localhost:8082';

  Future<T> post<T>({
    required String endpoint,
    required Map<String, dynamic> body,
    T Function(Map<String, dynamic>)? fromJson,
    String? key,
  }) async {
    try {
      final url = Uri.parse("$baseUrl/$endpoint");
      final defaultHeaders = {"Content-Type": 'application/json'};
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
}

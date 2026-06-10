import 'dart:io';

import 'package:chat_chit_flutter/core/app_constants.dart';
import 'package:chat_chit_flutter/models/user.dart';
import 'package:chat_chit_flutter/services/api_client_service.dart';

class AuthService {
  AuthService({ApiClientService? apiClient})
      : _apiClient = apiClient ?? ApiClientService();

  final ApiClientService _apiClient;

  Future<User> login({
    required String email,
    required String password,
  }) async {
    return _apiClient.post(
      endpoint: '${AppConstants.apiPrefix}/auth/login',
      body: {'email': email, 'password': password},
      fromJson: User.fromJson,
      key: 'userData',
    );
  }

  Future<String> register({
    required String email,
    required String username,
    required String password,
    File? image,
  }) async {
    String? imageName;
    if (image != null) {
      imageName = await _apiClient.postFile(
        endpoint: '${AppConstants.apiPrefix}/upload',
        fileToUpload: image,
        key: 'fileName',
      );
    }
    return _apiClient.post(
      endpoint: '${AppConstants.apiPrefix}/auth/register',
      body: {
        'email': email,
        'username': username,
        'password': password,
        'avatarUrl': imageName,
      },
      key: 'message',
    );
  }
}

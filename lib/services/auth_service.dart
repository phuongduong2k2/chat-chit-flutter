import 'package:chat_chit_flutter/models/user.dart';
import 'package:chat_chit_flutter/services/api_client_service.dart';

class AuthService {
  static ApiClientService apiClientService = ApiClientService();

  Future<User> login({required String email, required String password}) async {
    try {
      final result = await apiClientService.post(
        endpoint: "api/v1/auth/login",
        body: {"email": email, "password": password},
        fromJson: User.fromJson,
        key: "userData",
      );
      return result;
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<String> register({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      final result = await apiClientService.post(
        endpoint: "api/v1/auth/register",
        body: {"email": email, "username": username, "password": password},
        key: 'message',
      );
      return result;
    } on Exception catch (_) {
      rethrow;
    }
  }
}

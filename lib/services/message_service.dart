import 'package:chat_chit_flutter/models/message.dart';
import 'package:chat_chit_flutter/services/api_client_service.dart';

class MessageService {
  static ApiClientService apiClientService = ApiClientService();

  Future<void> sendMessage(
    String message,
    String username,
    String createdAt,
  ) async {
    try {
      await apiClientService.post(
        endpoint: '/api/v1/messages/$username',
        body: {"message": message, "createdAt": createdAt},
      );
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<List<Message>> getAllMessages() async {
    try {
      final response = await apiClientService.get(
        endpoint: "/api/v1/messages",
        key: "messages",
      );
      final List<dynamic> jsonList = response;
      return jsonList.map((json) => Message.fromJson(json)).toList();
    } on Exception catch (_) {
      rethrow;
    }
  }
}

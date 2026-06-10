import 'package:chat_chit_flutter/core/app_constants.dart';
import 'package:chat_chit_flutter/models/message.dart';
import 'package:chat_chit_flutter/services/api_client_service.dart';

class MessageService {
  MessageService({ApiClientService? apiClient})
      : _apiClient = apiClient ?? ApiClientService();

  final ApiClientService _apiClient;

  Future<void> sendMessage({
    required String message,
    required String username,
    required DateTime createdAt,
  }) async {
    await _apiClient.post(
      endpoint: '${AppConstants.apiPrefix}/messages/$username',
      body: {
        'message': message,
        'createdAt': createdAt.toIso8601String(),
      },
    );
  }

  Future<List<Message>> getAllMessages() async {
    final response = await _apiClient.get<dynamic>(
      endpoint: '${AppConstants.apiPrefix}/messages',
      key: 'messages',
    );
    final list = response as List<dynamic>;
    return list
        .map((json) => Message.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

import 'package:chat_chit_flutter/models/message.dart';
import 'package:chat_chit_flutter/services/message_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final MessageService messageService = MessageService();

final messageProvider = FutureProvider<List<Message>>((ref) async {
  final response = await messageService.getAllMessages();
  return response;
});

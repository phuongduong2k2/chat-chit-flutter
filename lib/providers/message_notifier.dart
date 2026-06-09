import 'package:chat_chit_flutter/models/message.dart';
import 'package:chat_chit_flutter/services/message_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message_notifier.g.dart';

@riverpod
class MessageNotifier extends _$MessageNotifier {
  final MessageService messageService = MessageService();

  @override
  Future<List<Message>> build() async {
    return await messageService.getAllMessages();
  }

  void add(Message message) async {
    final previousState = await future;
    state = AsyncData([
      ...previousState,
      message,
    ]);
  }
}

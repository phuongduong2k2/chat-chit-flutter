import 'package:chat_chit_flutter/models/message.dart';
import 'package:chat_chit_flutter/services/message_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message_notifier.g.dart';

@riverpod
class MessageNotifier extends _$MessageNotifier {
  late final MessageService _messageService;

  @override
  Future<List<Message>> build() async {
    _messageService = MessageService();
    return _messageService.getAllMessages();
  }

  void add(Message message) {
    final previous = state.asData?.value ?? [];
    state = AsyncData([...previous, message]);
  }
}

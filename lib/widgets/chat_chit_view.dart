import 'package:chat_chit_flutter/providers/message_notifier.dart';
import 'package:chat_chit_flutter/providers/user_notifier.dart';
import 'package:chat_chit_flutter/widgets/left_message.dart';
import 'package:chat_chit_flutter/widgets/right_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatChitView extends ConsumerWidget {
  const ChatChitView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesAsync = ref.watch(messageProvider);
    final user = ref.read(userProvider)!;

    return messagesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, e) => const Center(child: Text('Something went wrong')),
      data: (messages) => ListView.separated(
        itemCount: messages.length,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        separatorBuilder: (_, i) => const SizedBox(height: 10),
        itemBuilder: (_, index) {
          final message = messages[index];
          return message.user.username == user.username
              ? RightMessage(message: message)
              : LeftMessage(message: message);
        },
      ),
    );
  }
}

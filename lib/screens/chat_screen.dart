import 'package:chat_chit_flutter/extensions/exception_extension.dart';
import 'package:chat_chit_flutter/models/message.dart';
import 'package:chat_chit_flutter/models/user.dart';
import 'package:chat_chit_flutter/providers/message_notifier.dart';
import 'package:chat_chit_flutter/providers/user_notifier.dart';
import 'package:chat_chit_flutter/services/message_service.dart';
import 'package:chat_chit_flutter/utils/utils.dart';
import 'package:chat_chit_flutter/widgets/chat_chit_view.dart';
import 'package:chat_chit_flutter/widgets/circle_image.dart';
import 'package:chat_chit_flutter/widgets/message_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _messageService = MessageService();

  void _exitToApp() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Logout?'),
        actions: [
          TextButton(
            onPressed: Navigator.of(ctx).pop,
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
              ref.read(userProvider.notifier).clearUser();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  Future<void> _onSubmit(String value, User user) async {
    try {
      final createdAt = DateTime.now();
      await _messageService.sendMessage(
        message: value,
        username: user.username,
        createdAt: createdAt,
      );
      ref
          .read(messageProvider.notifier)
          .add(
            Message(user: user, message: value, createdAt: createdAt),
          );
    } on Exception catch (ex) {
      if (!mounted) return;
      showSnackBar(context, ex.cleanMessage, SnackBarType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider)!;

    return Consumer(
      builder: (context, ref, child) => Scaffold(
        appBar: AppBar(
          title: Text(user.username),
          leading: CircleImage(user: user),
          automaticallyImplyLeading: false,
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: _exitToApp,
              icon: const Icon(Icons.exit_to_app),
            ),
          ],
        ),
        body: Column(
          children: [
            const Expanded(child: ChatChitView()),
            MessageInput(onSend: (value) => _onSubmit(value, user)),
          ],
        ),
      ),
    );
  }
}

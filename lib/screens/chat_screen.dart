import 'package:chat_chit_flutter/models/user.dart';
import 'package:chat_chit_flutter/providers/user_provider.dart';
import 'package:chat_chit_flutter/widgets/chat_chit_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  void _exitToApp() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Logout?"),
        actions: [
          TextButton(
            onPressed: Navigator.of(ctx).pop,
            child: Text("No"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
              ref.read(userProvider.notifier).clearUser();
            },
            child: Text("Yes"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final User user = ref.read(userProvider)!;

    return Scaffold(
      appBar: AppBar(
        title: Text("Hello ${user.username}"),
        leading: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: BoxBorder.all(
              width: 1,
              color: Colors.black.withValues(alpha: 0.2),
            ),
          ),
          clipBehavior: .hardEdge,
          child: CircleAvatar(
            radius: 42,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: user.avatarUrl != null
                  ? NetworkImage(user.getAvatarUrl())
                  : null,
              child: user.avatarUrl != null
                  ? null
                  : Text(
                      user.username[0].toUpperCase(),
                      style: TextStyle(fontSize: 20),
                    ),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: _exitToApp,
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: ChatChitView(),
    );
  }
}

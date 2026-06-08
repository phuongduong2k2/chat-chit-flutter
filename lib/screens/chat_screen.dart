import 'package:chat_chit_flutter/models/user.dart';
import 'package:chat_chit_flutter/providers/user_provider.dart';
import 'package:chat_chit_flutter/widgets/chat_chit_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

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
        leading: user.avatarUrl != null
            ? Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                clipBehavior: .hardEdge,
                child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(user.getAvatarUrl()),
                  fit: .contain,
                  width: double.infinity,
                ),
              )
            : SizedBox(),
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

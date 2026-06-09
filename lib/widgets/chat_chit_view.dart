import 'package:chat_chit_flutter/providers/message_provider.dart';
import 'package:chat_chit_flutter/providers/user_provider.dart';
import 'package:chat_chit_flutter/widgets/left_message.dart';
import 'package:chat_chit_flutter/widgets/right_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatChitView extends StatelessWidget {
  const ChatChitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (ctx, ref, child) {
        final messages = ref.watch(messageProvider);
        final user = ref.read(userProvider)!;

        if (messages.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (messages.hasError) {
          return Center(
            child: Text("Some thing wrong"),
          );
        }

        if (messages.hasValue) {
          return ListView.separated(
            itemCount: messages.value!.length,
            padding: EdgeInsets.symmetric(horizontal: 10),
            separatorBuilder: (context, index) => SizedBox(
              height: 10,
            ),
            itemBuilder: (ctx, index) {
              final message = messages.value![index];
              return SizedBox(
                child: message.user.username == user.username
                    ? RightMessage(message: message)
                    : LeftMessage(message: message),
              );
            },
          );
        }
        return Text("EMpty");
      },
    );
  }
}

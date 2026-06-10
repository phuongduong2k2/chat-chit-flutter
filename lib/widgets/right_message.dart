import 'package:chat_chit_flutter/models/message.dart';
import 'package:chat_chit_flutter/widgets/circle_image.dart';
import 'package:flutter/material.dart';

class RightMessage extends StatelessWidget {
  const RightMessage({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.user.username,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Colors.grey.withValues(alpha: 0.5),
              ),
              child: Text(
                message.message,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        CircleImage(user: message.user, size: 40),
      ],
    );
  }
}

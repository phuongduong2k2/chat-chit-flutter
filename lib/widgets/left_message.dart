import 'package:chat_chit_flutter/models/message.dart';
import 'package:chat_chit_flutter/widgets/circle_image.dart';
import 'package:flutter/material.dart';

class LeftMessage extends StatelessWidget {
  const LeftMessage({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleImage(
          user: message.user,
          size: 40,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.user.username,
              style: TextStyle(fontSize: 16, fontWeight: .bold),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                message.message,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

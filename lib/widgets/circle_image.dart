import 'package:chat_chit_flutter/models/user.dart';
import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({super.key, required this.user, this.size = 80});

  final User user;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 1,
          color: Colors.black.withValues(alpha: 0.2),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: CircleAvatar(
        radius: size / 2,
        backgroundImage:
            user.avatarUrl.isNotEmpty ? NetworkImage(user.avatarUrl) : null,
        child: user.avatarUrl.isEmpty
            ? Text(
                user.username[0].toUpperCase(),
                style: const TextStyle(fontSize: 20),
              )
            : null,
      ),
    );
  }
}

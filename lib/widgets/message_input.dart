import 'package:flutter/material.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({super.key, required this.onSend});

  final Function(String inputValue) onSend;

  @override
  Widget build(BuildContext context) {
    final EdgeInsets safeAreaPadding = MediaQuery.paddingOf(context);
    String inputValue = "";

    return Container(
      margin: EdgeInsets.only(
        bottom: safeAreaPadding.bottom,
        left: 10,
        right: 10,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) => inputValue = value,
            ),
          ),
          IconButton(
            onPressed: () {
              onSend(inputValue);
            },
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, required this.onTap, this.image});

  final File? image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(100),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 100,
          height: 100,
          child: image != null
              ? Ink.image(
                  image: FileImage(image!),
                  fit: BoxFit.cover,
                )
              : const Center(
                  child: Icon(
                    Icons.add_photo_alternate,
                    color: Colors.black,
                  ),
                ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({super.key, required this.onTap, this.image});

  final File? image;
  final Function() onTap;

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  File? image;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(100),
      clipBehavior: .hardEdge,
      child: InkWell(
        onTap: widget.onTap,
        child: SizedBox(
          width: 100,
          height: 100,
          child: widget.image != null
              ? Ink.image(
                  image: FileImage(
                    widget.image!,
                  ),
                  fit: .cover,
                )
              : Center(
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

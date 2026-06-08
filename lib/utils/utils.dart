import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

Future<File> copyFile({required File file, bool? isRandomName = false}) async {
  final appDir = await getApplicationDocumentsDirectory();
  var fileName = basename(file.path);
  if (isRandomName!) {
    final fileType = fileName.split(".")[1];
    fileName = "${uuid.v4()}.$fileType";
  }
  final File copiedFile = await file.copy("${appDir.path}/$fileName");
  return copiedFile;
}

enum SnackBarType { success, error }

void showSnackBar(
  BuildContext context,
  String message,
  SnackBarType snackBarType,
) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      persist: false,
      backgroundColor: snackBarType == SnackBarType.success
          ? Colors.green
          : Colors.red,
      action: SnackBarAction(
        label: "Ok",
        onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar,
      ),
    ),
  );
}

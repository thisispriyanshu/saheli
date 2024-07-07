import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

void showSnackBar(BuildContext context, String message, Color color) {
  final SnackBar snackbar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
      ),
    ),
    backgroundColor: color,
    margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    dismissDirection: DismissDirection.horizontal,
    duration: const Duration(seconds: 5), // Set duration
    action: SnackBarAction(
      label: 'OK',
      textColor: Colors.black,
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

FirebaseStorage _storage = FirebaseStorage.instance;

Future<XFile?> captureImage(ImageSource src) async {
  final ImagePicker picker = ImagePicker();
  XFile? image = await picker.pickImage(source: src);

  if (image != null) return image;
  return null;
}

Future<String> uploadFileToStorage(String childName, XFile? file) async {
  try {
    if (file == null) {
      throw Exception('File is null');
    }

    Uuid uuid = const Uuid();
    String id = uuid.v4();
    Reference ref = _storage.ref().child(childName).child(id);

    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpg');

    UploadTask uploadTask = ref.putFile(File(file.path), metadata);

    await uploadTask;

    String downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  } catch (e) {
    throw Exception('Error uploading file: $e');
  }
}
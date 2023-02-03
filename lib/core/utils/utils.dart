import 'dart:io';

import 'package:appointment_schedule_app/features/home/screens/home_screen.dart';

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar(String text) {
  scaffoldKey.currentContext!.showFlashBar(
    content: Text(
      text,
      style: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    duration: const Duration(seconds: 4),
    horizontalDismissDirection: HorizontalDismissDirection.horizontal,
    backgroundColor: Colors.black,
    position: FlashPosition.bottom,
    margin: const EdgeInsets.all(8),
    borderRadius: const BorderRadius.all(Radius.circular(8)),
    forwardAnimationCurve: Curves.bounceIn,
    reverseAnimationCurve: Curves.slowMiddle,
    icon: const Icon(
      Icons.info,
      color: Colors.white,
    ),
    shouldIconPulse: true,
  );
}

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showSnackBar(e.toString());
  }
  return image;
}

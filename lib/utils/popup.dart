import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TPopup {
  /// Displays a success snackbar with a custom title and message.
  static successSnackbar({required String message}) {
    Get.snackbar(
      'Success',
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.black54,
      backgroundColor: Colors.greenAccent,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      icon: const Icon(Icons.thumb_up, color: Colors.black54),
    );
  }

  /// Displays a warning snackbar with a custom title and message.
  static warningSnackbar({required String message}) {
    Get.snackbar(
      'Warning',
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.black54,
      backgroundColor: Colors.yellowAccent,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      icon: const Icon(Icons.warning, color: Colors.black54),
    );
  }

  /// Displays an error snackbar with a custom title and message.
  static errorSnackbar({required String message}) {
    Get.snackbar(
      'Error',
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: Colors.redAccent,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      icon: const Icon(Icons.gpp_bad, color: Colors.white),
    );
  }
}

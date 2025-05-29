import 'package:candy_app/decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


 CustomSnackBar(String title, String message, String type) {
  Future.delayed(Duration.zero, () {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: type == "error" ? red : green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      dismissDirection: DismissDirection.up,
    );
  });
}
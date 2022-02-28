import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackBar(title, message) {
  Get.snackbar(
    title,
    message,
    barBlur: 0.0,
    icon: const Padding(
      padding: EdgeInsets.only(left: 8,right: 8),
      child: Icon(
        Icons.info_outline,
        color: Colors.white,
        size: 32,
      ),
    ),
    colorText: Colors.white,
    backgroundColor: Colors.indigo,
    margin: const EdgeInsets.all(16),
    borderRadius: 8,
  );
}

import 'package:flutter/material.dart';

class ButtonStyles {

  static ButtonStyle primaryButton() {
    return ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

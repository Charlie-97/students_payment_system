import 'package:flutter/material.dart';
import 'package:students_payment_system/utils/router/base_navigator.dart';

class MySnackBar {
  final String message;

  MySnackBar(this.message);

  SnackBar build() {
    final colorScheme = Theme.of(BaseNavigator.currentContext)
        .colorScheme; // Replace with your app's theme

    return SnackBar(
      backgroundColor: colorScheme.primary, // Background color
      content: Center(
        child: Text(
          message,
          style: TextStyle(
            color: colorScheme.onPrimary, // Text color
          ),
        ),
      ),
      duration: const Duration(seconds: 3),
    );
  }
}

Future<void> showMySnackBar(SnackBar snackBar) async {
  ScaffoldMessenger.of(BaseNavigator.key.currentContext!)
      .showSnackBar(snackBar);
}

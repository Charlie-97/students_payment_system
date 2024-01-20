import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:students_payment_system/presentation/pages/splash_page.dart';
import 'package:students_payment_system/utils/constants.dart';
import 'package:students_payment_system/utils/router/base_navigator.dart';

enum AlertType {
  success,
  error,
  random,
}

class AppFunction {
  static Color _getTypeColor(AlertType type) {
    switch (type) {
      case AlertType.random:
        return const Color(0xFFA3A3A5);
      case AlertType.success:
        return Colors.green;
      case AlertType.error:
        return const Color(0xFFAD2121);
      default:
        return const Color(0xFF160A0A);
    }
  }

  static showAlert(
    BuildContext context,
    String txt, {
    AlertType type = AlertType.random,
    StyledToastPosition position = StyledToastPosition.top,
  }) {
    return showToastWidget(
      Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 18.0,
          vertical: 8.0,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 50.0,
        ),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          color: _getTypeColor(type),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                txt,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            // IconButton(
            //   onPressed: () {
            //     ToastManager().dismissAll(showAnim: true);
            //   },
            //   icon: const Icon(
            //     Icons.cancel,
            //     color: Colors.white,
            //   ),
            // ),
          ],
        ),
      ),
      context: context,
      isIgnoring: false,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: position,
      animDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 4),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
    );
  }

  static String getNameInitials(String name) {
    var seperateName = name.split(" ");
    String nameInit = seperateName[0][0] + seperateName[1][0];
    return nameInit;
  }

  static void copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    showAlert(context, 'Copied to clipboard', type: AlertType.success);
  }

  static Future<void> logout() async {
    final box = Hive.box(Boxes.authBox);
    box.clear();
    if (BaseNavigator.key.currentState != null) {
      BaseNavigator.key.currentState!.pushNamed(
        SplashScreen.routeName,
        arguments: 1,
      );
    }
  }

  static Future<void> softlogout() async {
    if (BaseNavigator.key.currentState != null) {
      BaseNavigator.key.currentState!.pushReplacementNamed(
        SplashScreen.routeName,
        arguments: 1,
      );
    }
  }

  static void forcedLogout(String message) {
    if (message == "User not logged in") logout();
  }
}

Function setPasswordVisibility({required bool obscureText}) {
  return () {
    obscureText = !obscureText;
    return obscureText ? Icons.visibility : Icons.visibility_off;
  };
}

bool checkPasswordsMatch({
  required String password,
  required String passwordConfirmation,
}) {
  return password == passwordConfirmation || passwordConfirmation.isEmpty;
}

bool containsSpecialCharacter(String password) {
  final List<String> usableSpecialCharacters = [
    '#',
    '@',
    '\$',
    '&',
    '-',
    '!',
    '%',
    '^'
  ];

  return usableSpecialCharacters.any((element) => password.contains(element));
}

bool containsUpperCase(String password) {
  for (int i = 0; i < password.length; i++) {
    if (password[i].toUpperCase() == password[i]) {
      return true;
    }
  }
  return false;
}

bool containsLowerCase(String password) {
  for (int i = 0; i < password.length; i++) {
    if (password[i].toLowerCase() == password[i]) {
      return true;
    }
  }
  return false;
}

bool validateSignUp(email, password, confirmPassword) {
  return validateEmail(email: email) &&
      ((password != null || password.trim().isNotEmpty) &&
          (password.contains(RegExp(r'[A-Z]'))) &&
          (password.contains(RegExp(r'[a-z]'))) &&
          (password.contains(RegExp(r'[0-9]'))) &&
          (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) &&
          (!password.contains(RegExp(r'\s'))) &&
          (password.length >= 8)) &&
      (confirmPassword == password);
}

String? validatePassword(String? value) {
  if (value!.length < 6) {
    return 'Password must be at least 6 characters';
  }
  // if (value == null || value.trim().isEmpty) {
  //   return 'Please enter your password';
  // }
  // if (!value.contains(RegExp(r'[A-Z]'))) {
  //   return 'Password must contain at least one uppercase letter';
  // }
  // if (!value.contains(RegExp(r'[a-z]'))) {
  //   return 'Password must contain at least one lowercase letter';
  // }

  // if (!value.contains(RegExp(r'[0-9]'))) {
  //   return 'Password must contain at least one number';
  // }

  // if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
  //   return 'Password must contain at least one special character';
  // }

  // if (value.contains(RegExp(r'\s'))) {
  //   return 'Password must not contain whitespace';
  // }
  // if (value.length < 8) {
  //   return 'Your Password must contain at least 8 characters';
  // }
  return null;
}

bool validateEmail({required String email}) {
  return email.contains('@') &&
      email.contains('.') &&
      !email.contains(' ') &&
      (email.substring(email.length - 1) != '.' &&
          email.substring(email.length - 1) != '@');
}

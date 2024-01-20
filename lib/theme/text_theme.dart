import 'package:flutter/material.dart';

class AppTextTheme {
  static TextStyle bodyMedium(BuildContext context) {
    final body = Theme.of(context).textTheme.bodyMedium;
    return body!;
  }

  static TextStyle bodyLarge(BuildContext context) {
    final body = Theme.of(context).textTheme.bodyLarge;
    return body!;
  }

  static TextStyle bodySmall(BuildContext context) {
    final body = Theme.of(context).textTheme.bodySmall;
    return body!;
  }
}

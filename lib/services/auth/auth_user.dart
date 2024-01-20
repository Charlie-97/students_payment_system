import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final String id;
  final bool isEmailVerified;
  final String email;
  final String? displayName;

  const AuthUser({
    // required this.name,
    required this.id,
    required this.email,
    required this.isEmailVerified,
    this.displayName,
  });
}

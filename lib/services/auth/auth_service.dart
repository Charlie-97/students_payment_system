

import 'package:students_payment_system/services/auth/auth_provider.dart' as my_auth_provider;
import 'package:students_payment_system/services/auth/auth_user.dart';
import 'package:students_payment_system/services/auth/app_auth_provider.dart';

class AuthService implements my_auth_provider.AuthProvider {
  final my_auth_provider.AuthProvider provider;
  const AuthService(this.provider);

  factory AuthService.firebase() => AuthService(AppAuthProvider());

  @override
  Future<AuthUser> createUser(
          {required String email, required String password}) =>
      provider.createUser(email: email, password: password);

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> login({required String email, required String password}) =>
      provider.login(email: email, password: password);

  @override
  Future<void> logout() => provider.logout();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<void> updateDisplayName({required String displayName}) =>
      provider.updateDisplayName(displayName: displayName);

  @override
  Future<void> resetPassword(String email) => provider.resetPassword(email);
}

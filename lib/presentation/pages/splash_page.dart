import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:students_payment_system/presentation/pages/authentication/email_verification_page.dart';
import 'package:students_payment_system/presentation/pages/authentication/login_page.dart';
import 'package:students_payment_system/presentation/pages/dashboard_page.dart';
import 'package:students_payment_system/presentation/widgets/snackbar_messages.dart';
import 'package:students_payment_system/services/auth/auth_service.dart';
import 'package:students_payment_system/utils/router/base_navigator.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "splash";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initCheck();
  }

  initCheck() async {
    await Future.delayed(const Duration(seconds: 5));

    final AuthService authService = AuthService.firebase();
    final user = authService.currentUser;

    Future<bool> isUserLoggedIn() async {
      return user != null;
    }

    if (await isUserLoggedIn()) {
      if (user?.isEmailVerified ?? false) {
        final snackBar = MySnackBar(
          'Signed in Successfully as ${user?.displayName}!',
        ).build();
        ScaffoldMessenger.of(BaseNavigator.key.currentContext!)
            .showSnackBar(snackBar);
        BaseNavigator.pushNamedAndClear(DashboardPage.routeName);
      } else {
        BaseNavigator.pushNamedAndClear(VerifyEmailPage.routeName);
      }
    } else {
      BaseNavigator.pushNamedAndClear(LoginPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeInDown(
                duration: const Duration(seconds: 1),
                child: Icon(
                  Icons.payments_outlined,
                  size: 100.0,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              const SizedBox(height: 12.0),
              FadeInLeft(
                duration: const Duration(seconds: 1),
                child: Text(
                  'EduPay',
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              FadeInRight(
                duration: const Duration(seconds: 2),
                child: Text(
                  'Payment Simplified...',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w200,
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

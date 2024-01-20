import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:students_payment_system/presentation/pages/authentication/login_page.dart';
import 'package:students_payment_system/utils/icons.dart';
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
    BaseNavigator.pushNamedAndClear(LoginPage.routeName);

    //   if (await isUserLoggedIn()) {
    //     if (user?.isEmailVerified ?? false) {
    //       final snackBar = MySnackBar(
    //         'Signed in Successfully as ${user?.displayName}!',
    //       ).build();
    //       ScaffoldMessenger.of(BaseNavigator.key.currentContext!)
    //           .showSnackBar(snackBar);
    //       BaseNavigator.pushNamedAndClear(HomePage.routeName);
    //     } else {
    //       BaseNavigator.pushNamedAndClear(VerifyEmailPage.routeName);
    //     }
    //   } else {
    //     BaseNavigator.pushNamedAndClear(LoginPage.routeName);
    //   }
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
                  UIcons.shopping_bag,
                  size: 100.0,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              const SizedBox(height: 12.0),
              FadeInLeft(
                duration: const Duration(seconds: 1),
                child: Text(
                  'UniMart',
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
                  '...easy shopping',
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

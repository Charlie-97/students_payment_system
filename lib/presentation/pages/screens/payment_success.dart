import 'package:flutter/material.dart';
import 'package:students_payment_system/presentation/pages/home_page.dart';
import 'package:students_payment_system/utils/router/base_navigator.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({super.key});
  static const routeName = 'payment_success';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: 50,
          child: TextButton(
            onPressed: () {
              BaseNavigator.key.currentState!.pushNamedAndRemoveUntil(
                HomePage.routeName,
                (route) => false,
              );
            },
            child: const Text(
              "Go to Home",
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      body: const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 150,
            ),
            SizedBox(height: 12),
            Text(
              "Order placed Successfully\nThank you for shopping with us.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

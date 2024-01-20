import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:students_payment_system/services/apis/auth_service.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => AuthService()),
];

abstract class DisposableProvider with ChangeNotifier {
  void disposeValues();
}

class AppProviders {
  static List<DisposableProvider> getDisposableProviders(BuildContext context) {
    return [
      Provider.of<AuthService>(context, listen: false),
    ];
  }

  static void disposeAllDisposableProviders(BuildContext context) {
    getDisposableProviders(context).forEach((disposableProvider) {
      disposableProvider.disposeValues();
    });
  }
}

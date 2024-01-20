import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:students_payment_system/presentation/pages/authentication/register_page.dart';
import 'package:students_payment_system/presentation/widgets/buttons_widget.dart';
import 'package:students_payment_system/presentation/widgets/dialogue_boxes.dart';
import 'package:students_payment_system/services/apis/auth_service.dart';
import 'package:students_payment_system/utils/icons.dart';
import 'package:students_payment_system/utils/router/base_navigator.dart';

class LoginPage extends HookWidget {
  const LoginPage({super.key});
  static const routeName = 'login_page';

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.sizeOf(context).width;
    final userEmail = useTextEditingController();
    final userPassword = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    var showPass = useState(true);
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await showCloseDialog(context);
        if (shouldPop) {
          exit(0);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Login",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0.5,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome 👋!!!',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 12.0),
                      Text(
                        'Fill in your credentials below and hit the login button to continue',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  TextFormField(
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: userEmail,
                    onTapOutside: (_) {
                      FocusScope.of(context).unfocus();
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Empty field";
                      }

                      return null;
                    },
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      labelText: 'Username',
                      hintText: 'example',
                      prefixIcon: const Icon(UIcons.user),
                      prefixIconColor:
                          Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    obscureText: showPass.value,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: userPassword,
                    textInputAction: TextInputAction.done,
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(UIcons.lock),
                      prefixIconColor:
                          Theme.of(context).colorScheme.onBackground,
                      suffixIconColor:
                          Theme.of(context).colorScheme.onBackground,
                      suffixIcon: IconButtonWidget(
                        onPressed: () {
                          showPass.value = !showPass.value;
                        },
                        icon: showPass.value ? UIcons.eye_slash : UIcons.eye,
                      ),
                      // suffixIcon: IconButton(
                      //   onPressed: () {},
                      //   icon: passwordVisibilityIcon,
                      // ),
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Consumer<AuthService>(
                    builder: (context, state, child) {
                      return state.isLoading
                          ? const CircularProgressIndicator.adaptive()
                          : ElevatedButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  state.login(
                                    context,
                                    uname: userEmail.text,
                                    pass: userPassword.text,
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(deviceWidth, 30.0),
                              ),
                              child: const Text('Login'),
                            );
                    },
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Forgotten password?"),
                      const SizedBox(
                        width: 5.0,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Click here",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      const SizedBox(
                        width: 5.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          BaseNavigator.pushNamed(RegisterPage.routeName);
                        },
                        child: Text(
                          "Register here",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100.0,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

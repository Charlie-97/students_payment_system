import 'dart:io';

import 'package:flutter/material.dart';
import 'package:students_payment_system/presentation/widgets/dialogue_boxes.dart';
import 'package:students_payment_system/utils/functions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const routeName = 'login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _userEmail;

  late final TextEditingController _userPassword;

  bool obscurePassword = true;

  Icon passwordVisibilityIcon = const Icon(Icons.visibility);

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  final auth = AuthFunctions();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _userEmail = TextEditingController();
    _userPassword = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _userEmail.dispose();
    _userPassword.dispose();
    _passwordFocus.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.sizeOf(context).width;

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
            key: _formKey,
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
                  focusNode: _emailFocus,
                  onEditingComplete: () {
                    _passwordFocus.requestFocus();
                  },
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  controller: _userEmail,
                  onTapOutside: (_) {
                    FocusScope.of(context).unfocus();
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter your email";
                    }
                    if (!validateEmail(email: value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'example@whatevermail.com',
                    prefixIcon: const Icon(Icons.mail),
                    prefixIconColor: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                TextFormField(
                  focusNode: _passwordFocus,
                  obscureText: obscurePassword,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: _userPassword,
                  textInputAction: TextInputAction.done,
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    prefixIconColor: Theme.of(context).colorScheme.onBackground,
                    suffixIconColor: Theme.of(context).colorScheme.onBackground,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          final toggleVisibility = setPasswordVisibility(
                              obscureText: obscurePassword);
                          obscurePassword = !obscurePassword;
                          final newIconData = toggleVisibility();
                          passwordVisibilityIcon = Icon(newIconData);
                        });
                      },
                      icon: passwordVisibilityIcon,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final email = _userEmail.text;
                    final password = _userPassword.text;

                    await auth.signInWithEmailAndPassword(
                        context, email, password);
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(deviceWidth, 30.0),
                  ),
                  child: const Text('Login'),
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
                      onTap: () {
                        final email = _userEmail.text;
                        auth.resetPassword(context, email);
                      },
                      child: Text(
                        "Click here",
                        style: TextStyle(color: Theme.of(context).primaryColor),
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
                      onTap: () {},
                      child: Text(
                        "Register here",
                        style: TextStyle(color: Theme.of(context).primaryColor),
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
    );
  }
}

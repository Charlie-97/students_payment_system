import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:students_payment_system/presentation/pages/authentication/login_page.dart';
import 'package:students_payment_system/services/apis/auth_service.dart';
import 'package:students_payment_system/utils/router/base_navigator.dart';

class VendorReg extends StatefulWidget {
  const VendorReg({super.key});
  static const routeName = 'vendor_page';

  @override
  State<VendorReg> createState() => _VendorRegState();
}

class _VendorRegState extends State<VendorReg> {
  late final TextEditingController bnkName, bvn, accNum, bizName, bizPhone;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    bnkName = TextEditingController();
    bvn = TextEditingController();
    accNum = TextEditingController();
    bizName = TextEditingController();
    bizPhone = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    bnkName.dispose();
    bvn.dispose();
    accNum.dispose();
    bizName.dispose();
    bizPhone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Theme.of(context).colorScheme.onBackground,
            size: 24.0,
          ),
          onPressed: () {
            BaseNavigator.pop();
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 14.0,
                  ),
                  Text(
                    'Become a Vendor',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    "Please fill in the form below and let's get started.",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.name,
                    controller: bizName,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onChanged: (_) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      labelText: 'Business Name',
                      hintText: '',
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor:
                          Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  TextFormField(
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.name,
                    controller: bizPhone,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onChanged: (_) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      labelText: 'Business Phone Number',
                      hintText: '',
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor:
                          Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  TextFormField(
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.name,
                    controller: bnkName,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onChanged: (_) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      labelText: 'Bank Name',
                      hintText: '',
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor:
                          Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  TextFormField(
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.name,
                    controller: bvn,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onChanged: (_) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      labelText: 'BVN Number',
                      hintText: '',
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor:
                          Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  TextFormField(
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.number,
                    controller: accNum,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Empty value de';
                      }
                      return null;
                    },
                    onChanged: (_) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      labelText: 'Account Number',
                      hintText: '',
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor:
                          Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Consumer<AuthService>(
                    builder: (context, state, child) {
                      return state.isLoading
                          ? const CircularProgressIndicator.adaptive()
                          : ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // state.register(
                                  //   context,
                                  //   email: _userEmail.text,
                                  //   pass: _userPassword.text,
                                  //   uname: _userName.text,
                                  // );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(deviceWidth, 30.0),
                              ),
                              child: const Text('Register'),
                            );
                    },
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      const SizedBox(
                        width: 5.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          BaseNavigator.pushNamed(LoginPage.routeName);
                        },
                        child: Text(
                          "Login Here",
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

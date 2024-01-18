import 'package:flutter/material.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {},
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "Reset Password",
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
        child: Column(
          children: [
            Text(
              '''An email has been sent to you, please click the link to reset your password.\nOnce reset, click continue to login with new password.
                ''',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              'Did not receive the email? Click the button below to resend the password reset email',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 24.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Continue'),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[50],
                    foregroundColor: Colors.deepPurple,
                  ),
                  child: const Text('Resend Password Reset Email'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

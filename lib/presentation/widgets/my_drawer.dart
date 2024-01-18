import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:students_payment_system/presentation/widgets/dialogue_boxes.dart';
import 'package:students_payment_system/services/auth/auth_service.dart';
import 'package:students_payment_system/utils/functions.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  final AppOverlays _appOverlays = AppOverlays();
  final AuthService _authService = AuthService.firebase();

  @override
  Widget build(BuildContext context) {
    final userName = _authService.currentUser!.displayName!;

    final firstLetter = userName.substring(0, 1);

    final auth = AuthFunctions();
    late final signout = auth.signOutUser(context);

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 36.0,
                  child: Text(
                    firstLetter,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: Text(
                    // _authService.currentUser!.email.split('@').first,
                    _authService.currentUser!.displayName!,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: const SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Profile'),
                    ),
                    ListTile(
                      title: Text('Starred Notes'),
                    ),
                    Divider(
                      thickness: 1.0,
                    ),
                    ListTile(
                      title: Text('Settings'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: TextButton.icon(
              onPressed: () async {
                final shouldLogout =
                    await _appOverlays.showLogOutDialog(context);
                devtools.log(shouldLogout.toString());
                if (shouldLogout) {
                  signout;
                }
              },
              icon: const Icon(Icons.logout),
              label: const Text('Log Out'),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:students_payment_system/presentation/pages/authentication/vendor_reg.dart';
import 'package:students_payment_system/utils/router/base_navigator.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const CircleAvatar(
              radius: 50,
              child: Text(
                "SA",
                style: TextStyle(fontSize: 38),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Samuel Adekunle",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                fontFamily: "Montserrat",
              ),
            ),
            const SizedBox(height: 3),
            const Text(
              "samuelbeebest@gmail.com",
              style: TextStyle(fontSize: 12, fontFamily: "Montserrat"),
            ),
            const SizedBox(height: 10),
            const ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.sell),
              title: const Text("Become a vendor"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                BaseNavigator.pushNamed(VendorReg.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:students_payment_system/presentation/pages/dashboard_page.dart';
import 'package:students_payment_system/presentation/pages/screens/account.dart';
import 'package:students_payment_system/utils/icons.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});
  static const routeName = 'home';

  @override
  Widget build(BuildContext context) {
    var children = [
      const DashboardPage(),
      const Center(child: Text("Categories")),
      const Center(child: Text("Shops")),
      const AccountPage(),
    ];
    var currentIndex = useState(0);
    var scaffoldKey = useState(GlobalKey<ScaffoldState>());
    return Scaffold(
      key: scaffoldKey.value,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 6,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        showUnselectedLabels: true,
        iconSize: 20,
        onTap: (index) {
          currentIndex.value = index;
        },
        currentIndex: currentIndex.value,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle:
            const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
        unselectedLabelStyle:
            const TextStyle(fontSize: 8, fontWeight: FontWeight.w500),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(UIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(UIcons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(UIcons.shopping_bag),
            label: 'Shops',
          ),
          BottomNavigationBarItem(
            label: 'Account',
            icon: Icon(UIcons.profile),
          ),
        ],
      ),
      body: children[currentIndex.value],
      // body: Center(
      //   child: Column(
      //     children: [
      //       Container(
      //         child: const Text('UniMart Home Page'),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

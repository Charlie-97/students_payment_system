import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:students_payment_system/presentation/pages/splash_page.dart';
import 'package:students_payment_system/services/auth/auth_service.dart';
import 'package:students_payment_system/utils/providers/edupay_state.dart';
import 'package:students_payment_system/utils/router/app_router.dart';
import 'package:students_payment_system/utils/router/base_navigator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AuthService.firebase().initialize();
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  runApp(
    ChangeNotifierProvider<EduPayState>(
      create: (context) => EduPayState(),
      child: const MyNotesApp(),
    ),
  );
}

class MyNotesApp extends StatefulWidget {
  const MyNotesApp({super.key});

  @override
  State<MyNotesApp> createState() => _MyNotesAppState();
}

class _MyNotesAppState extends State<MyNotesApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: BaseNavigator.key,
      title: 'EduPay',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: TextTheme(
          titleLarge: GoogleFonts.montserrat(
            fontSize: 30,
            color: Colors.black,
          ),
          titleMedium: GoogleFonts.montserrat(
            fontSize: 26,
            color: Colors.black,
          ),
          bodyMedium: GoogleFonts.roboto(
            fontSize: 20,
            color: Colors.black,
          ),
          bodyLarge: GoogleFonts.montserrat(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.purple[50],
          ),
        ),
      ),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: SplashScreen.routeName,
      debugShowCheckedModeBanner: false,
    );
  }
}

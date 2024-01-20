import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:students_payment_system/bloc/cart_bloc.dart';
import 'package:students_payment_system/presentation/pages/splash_page.dart';
import 'package:students_payment_system/services/hive_database.dart';
import 'package:students_payment_system/services/model/cart_model.dart';
import 'package:students_payment_system/utils/constants.dart';
import 'package:students_payment_system/utils/providers/provider_list.dart';
import 'package:students_payment_system/utils/router/app_router.dart';
import 'package:students_payment_system/utils/router/base_navigator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(CartDataAdapter());
  await Hive.openBox(Boxes.appBox);
  await Hive.openBox(Boxes.authBox);

  final myDatabase = MyDatabase();
  await myDatabase.openBox();

  runApp(MyNotesApp(myDatabase: myDatabase));
}

class MyNotesApp extends StatelessWidget {
  final MyDatabase? _myDatabase;
  // const MyNotesApp({super.key});
  const MyNotesApp({Key? key, MyDatabase? myDatabase})
      : _myDatabase = myDatabase,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _myDatabase,
      child: BlocProvider(
        create: (context) =>
            CartBloc(myDatabase: _myDatabase!)..add(CartLoadEvent()),
        child: MultiProvider(
          providers: providers,
          child: MaterialApp(
            navigatorKey: BaseNavigator.key,
            title: 'UniMart',
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
          ),
        ),
      ),
    );
  }
}

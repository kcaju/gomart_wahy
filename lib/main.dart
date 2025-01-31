import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gomart_wahy/controller/signin_screen_controller/signin_screen_controller.dart';
import 'package:gomart_wahy/controller/signup_screen_controller/signup_screen_controller.dart';
import 'package:gomart_wahy/firebase_options.dart';
import 'package:gomart_wahy/view/splashscreen/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SignupScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => SigninScreenController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

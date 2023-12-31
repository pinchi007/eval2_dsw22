import 'package:eval2_dsw22/pages/home.dart';
import 'package:eval2_dsw22/pages/login_page.dart';
import 'package:eval2_dsw22/pages/sing_up_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((_){
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 0, 217, 255)),
        useMaterial3: true,
      ),
      initialRoute: "/login",
      routes: {
        "/home":(context) => const Home(),
        "/login":(context) => const LoginPage(),
        "/signup":(context) => const SignUpPage(),
      },
    );
  }
}


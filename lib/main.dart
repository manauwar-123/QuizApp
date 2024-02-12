import 'package:flutter/material.dart';
import 'package:quiz_app/controller/auth.dart';
import 'package:quiz_app/screens/home_screen.dart';
import 'package:quiz_app/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quiz_app/screens/landing.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDS2uHZVaihLEQuYpGNwO4JtymtEv1Ye_E",
          authDomain: "simplequiapp.firebaseapp.com",
          databaseURL: "https://simplequiapp-default-rtdb.firebaseio.com",
          projectId: "simplequiapp",
          // storageBucket: "simplequiapp.appspot.com",
          messagingSenderId: "232977280075",
          appId: "1:232977280075:web:4f64930b1302e7a33df1ce"),
    );
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MyLoginPage(),
      ),
    );
  }
}

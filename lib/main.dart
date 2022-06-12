import 'package:asana_demo_2/firebase_options.dart';
import 'package:asana_demo_2/pages/dones.dart';
import 'package:asana_demo_2/pages/home.dart';
import 'package:asana_demo_2/pages/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future signInAnonymously() {
  return FirebaseAuth.instance.signInAnonymously();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.red,
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => const MainScreen(),
      '/todo': (context) => const Home(),
      '/dones': (context) => const DoneScreen(),
    },
  ),);
}

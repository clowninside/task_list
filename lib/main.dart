import 'package:asana_demo_2/pages/dones.dart';
import 'package:asana_demo_2/pages/home.dart';
import 'package:asana_demo_2/pages/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
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
      '/': (context) => MainScreen(),
      '/todo': (context) => Home(),
      '/dones': (context) => DoneScreen(),
    },
  ));
}

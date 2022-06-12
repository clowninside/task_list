import 'package:asana_demo_2/main.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white38,
      appBar: AppBar(
        title: const Text('Task List'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: () {
            signInAnonymously();
            Navigator.pushNamed(context, '/todo');
          }, child: const Text('Go To Tasks'),),
        ],
      ),
    );
  }
}

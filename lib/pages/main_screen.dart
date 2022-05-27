import 'package:flutter/material.dart';
import 'package:asana_demo_2/main.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white38,
      appBar: AppBar(
        title: Text('Task List'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: () {
            signInAnonymously();
            Navigator.pushNamed(context, '/todo');
          }, child: Text('Go To Tasks')),
          // ElevatedButton(onPressed: () {
          //   Navigator.pushNamed(context, '/dones');
          // }, child: Text('Go To Dones')),
        ],
      ),
    );
  }
}

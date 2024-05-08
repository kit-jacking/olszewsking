import 'package:flutter/material.dart';

class JulkaPage extends StatelessWidget {
  const JulkaPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/CAMERA-VIEW-SCREEN.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

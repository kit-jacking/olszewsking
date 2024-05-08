import 'package:flutter/material.dart';

class JulkaPage extends StatelessWidget {
  const JulkaPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
          child: Image(
            image: AssetImage("lib/assets/CAMERA-VIEW-SCREEN.jpg"),
            // fit: BoxFit.cover,
          ),
      ),
    );
  }
}

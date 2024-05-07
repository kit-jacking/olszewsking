import 'package:flutter/material.dart';

class IgorPage extends StatelessWidget {
  const IgorPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Powodzenia Igor! :)"),
            ],
          ),
        ),
      ),
    );
  }
}

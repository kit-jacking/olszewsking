import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class JulkaPage extends StatefulWidget {
  const JulkaPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _JulkaPageState createState() => _JulkaPageState();
}

class _JulkaPageState extends State<JulkaPage> {
  bool isTranslateMode = true; // Tryb przesuwania
  bool isRotateMode = false; // Tryb obracania

  double _xPosition = 0;
  double _yPosition = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double modelWidth = screenWidth * 0.8; // 80% szerokości ekranu
    double modelHeight = screenHeight * 0.8; // 80% wysokości ekranu
    double initialXPosition = (screenWidth - modelWidth) / 2; // Środek ekranu
    double initialYPosition = (screenHeight - modelHeight) / 2; // Środek ekranu

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          GestureDetector(
            // GestureDetector to handle touch events for model movement or rotation
            onPanUpdate: (details) {
              if (isTranslateMode) {
                setState(() {
                  _xPosition += details.delta.dx;
                  _yPosition += details.delta.dy;
                });
              } else if (isRotateMode) {

              }
            },
            behavior: HitTestBehavior.opaque, // Obsługuje zdarzenia, nawet jeśli dziecko przycisku jest przekrywane przez inne widgety
            child: Container(
              // Background image
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/assets/images/CAMERA-VIEW-SCREEN.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: _xPosition + initialXPosition,
            top: _yPosition + initialYPosition,
            child: Container(
              width: modelWidth,
              height: modelHeight,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2), // Dodanie czarnej ramki
              ),
              child: ModelViewer(
                src: 'lib/assets/objects/chair/chair_paint.glb',
                alt: 'chair model',
                scale: '0.3 0.3 0.3',
                cameraControls: isRotateMode,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                isTranslateMode = true;
                isRotateMode = false;
              });
            },
            backgroundColor: isTranslateMode ? Colors.green : null,
            child: Icon(Icons.move_down),
          ),
          SizedBox(width: 16), // Odstęp między przyciskami
          FloatingActionButton(
            onPressed: () {
              setState(() {
                isTranslateMode = false;
                isRotateMode = true;
              });
            },
            backgroundColor: isRotateMode ? Colors.green : null,
            child: Icon(Icons.rotate_left),
          ),
        ],
      ),
    );
  }
}

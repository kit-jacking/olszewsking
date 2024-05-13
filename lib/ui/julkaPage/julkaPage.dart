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
  double _scale = 0.5; // Initial scale value
  double _minScale = 0.1; // Minimal scale value
  double _maxScale = 1.2; // Maximal scale value

  bool isTranslateMode = true;
  bool isRotateMode = false;
  bool isScaleMode = false;
  bool cameraState = false;

  double _xPosition = 0;
  double _yPosition = 0;

  void handlePanUpdate(DragUpdateDetails details) {
    if (isTranslateMode) {
      setState(() {
        _xPosition += details.delta.dx;
        _yPosition += details.delta.dy;
      });
    } else if (isRotateMode) {
      setState(() {});
    }
  }

  void handleScaleUpdate(double value) {
    setState(() {
      // Limit the scale value to be within the allowed range
      _scale = value.clamp(_minScale, _maxScale);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double modelWidth = screenWidth * _scale;
    double modelHeight = screenHeight * _scale;

    double initialXPosition = (screenWidth - screenWidth) / 2;
    double initialYPosition = (screenHeight - screenHeight) / 2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onPanUpdate: handlePanUpdate,
            behavior: HitTestBehavior.opaque,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "lib/assets/images/CAMERA-VIEW_wo_icons.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: 32,
            top: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      isTranslateMode = true;
                      isRotateMode = !isRotateMode;
                      isScaleMode = false; // Disable scale mode when switching modes
                    });
                  },
                  backgroundColor: isTranslateMode ? Colors.green : null,
                  child: Icon(Icons.compare_arrows),
                ),
                SizedBox(width: 32),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      isTranslateMode = false;
                      isRotateMode = true;
                      isScaleMode = false; // Disable scale mode when switching modes
                    });
                  },
                  backgroundColor: isRotateMode ? Colors.green : null,
                  child: Icon(Icons.rotate_90_degrees_ccw),
                ),
                SizedBox(width: 32),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      isTranslateMode = false;
                      isRotateMode = false;
                      isScaleMode = true;
                    });
                  },
                  backgroundColor: isScaleMode ? Colors.green : null,
                  child: Icon(Icons.zoom_out_map),
                ),
              ],
            ),
          ),
          Visibility(
            visible: isScaleMode, // Only show slider when isScaleMode is true
            child: Positioned(
              left: 16,
              bottom: 16,
              child: Container(
                width: screenWidth - 32,
                child: Slider(
                  value: _scale,
                  min: _minScale,
                  max: _maxScale,
                  onChanged: (value) {
                    handleScaleUpdate(value);
                  },
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
              child: Stack(
                children: [
                  Container(
                    width: modelWidth,
                    height: modelHeight,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                  ),
                  // ModelViewer
                  ModelViewer(
                    src: 'lib/assets/objects/chair/chair_paint.glb',
                    alt: 'chair model',
                    scale: '$_scale $_scale $_scale',
                    cameraControls: isRotateMode,
                  ),
                  Text("  isRotateMode: ${isRotateMode}")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

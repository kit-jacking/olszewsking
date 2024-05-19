import 'package:decoartor/common/bloc/FurnitureBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../../main.dart';

class JulkaPage extends StatefulWidget {
  JulkaPage({super.key, required this.title});

  final String title;

  @override
  State<JulkaPage> createState() => _JulkaPageState();
}

class _JulkaPageState extends State<JulkaPage> {
  double _scale = 0.5; // Initial scale value
  double _minScale = 0.1; // Minimal scale value
  double _maxScale = 1.2; // Maximal scale value

  bool stateRotate = false;
  bool isTranslateMode = true;
  bool isRotateMode = false;
  bool isScaleMode = false;

  double _xPosition = 0;
  double _yPosition = 0;

  void handlePanUpdate(DragUpdateDetails details) {
    if (isTranslateMode) {
      setState(() {
        _xPosition += details.delta.dx;
        _yPosition += details.delta.dy;
      });
    } else if (isRotateMode) {
      setState(() {
        stateRotate = true;
      });
    }
  }

  void handleScaleUpdate(double value) {
    setState(() {
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

    return BlocListener<FurnitureBloc, FurnitureState>(
      listener: (context, state) {

      },
      child: Scaffold(
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
                    image: backgroundImage == null ? const AssetImage("lib/assets/images/CAMERA-VIEW_wo_icons.jpg") : FileImage(backgroundImage!) as ImageProvider,
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
                      cameraControls: true,
                    ),
                    Text(
                        "  isRotateMode: ${isRotateMode}, \n  stateRotate: ${stateRotate}")
                  ],
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
                          isRotateMode = false;
                          isScaleMode =
                              false; // Disable scale mode when switching modes
                        });
                      },
                      backgroundColor: isTranslateMode ? Colors.green : null,
                      child: SvgPicture.asset(
                        'lib/assets/icons/move.svg',
                        width: 24,
                        height: 24,
                      ),
                    ),
                    SizedBox(width: 32),
                    FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          isTranslateMode = false;
                          isRotateMode = true;
                          isScaleMode =
                              false; // Disable scale mode when switching modes
                        });
                      },
                      backgroundColor: isRotateMode ? Colors.green : null,
                      child: SvgPicture.asset(
                        'lib/assets/icons/rotate.svg',
                        width: 24,
                        height: 24,
                      ),
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
                      child: SvgPicture.asset(
                        'lib/assets/icons/resize.svg',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ]),
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
            Text(context.read<FurnitureBloc>().state.furnitureList.toString()),
          ],
        ),
      ),
    );
  }
}

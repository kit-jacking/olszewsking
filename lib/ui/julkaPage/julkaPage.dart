import 'package:decoartor/common/bloc/FurnitureBloc.dart';
import 'package:decoartor/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../../common/bloc/RouterBloc.dart';

class JulkaPage extends StatefulWidget {
  JulkaPage({super.key, required this.title});

  final String title;

  @override
  State<JulkaPage> createState() => _JulkaPageState();
}

class _JulkaPageState extends State<JulkaPage> {
  double _minScale = 0.1; // Minimal scale value
  double _maxScale = 1.2; // Maximal scale value

  bool stateRotate = false;
  bool isTranslateMode = true;
  bool isRotateMode = false;
  bool isScaleMode = false;

  static int maxNumberOfPiecesOfFurniture = 10;

  static const double defaultPosition = 0; // Initial scale value
  static const double defaultScale = 0.5; // Initial scale value

  List<double> xPositions = List.filled(maxNumberOfPiecesOfFurniture, defaultPosition);
  List<double> yPositions = List.filled(maxNumberOfPiecesOfFurniture, defaultPosition);
  List<double> scales = List.filled(maxNumberOfPiecesOfFurniture, defaultScale);

  int selectedModel = 0;

  void handleScaleUpdate(double value) {
    setState(() {
      scales[selectedModel] = value.clamp(_minScale, _maxScale);
    });
  }

  void handlePanUpdate(DragUpdateDetails details) {
    if (isTranslateMode) {
      setState(() {
        xPositions[selectedModel] += details.delta.dx;
        yPositions[selectedModel] += details.delta.dy;
      });
    } else if (isRotateMode) {
      setState(() {
        stateRotate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final modelsFilePaths =
        context.read<FurnitureBloc>().state.furnitureList;
    final numberOfPiecesOfFurniture = modelsFilePaths.length;

    selectModel(int i) {
      if (i >= numberOfPiecesOfFurniture) {
        selectedModel = 0;
        return;
      }
      if (i < 0) {
        selectedModel = numberOfPiecesOfFurniture - 1;
        return;
      }
      selectedModel = i;
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    void redirectToBackgroundChange(BuildContext context) {
      context
          .read<RouterBloc>()
          .add(RedirectRouterEvent("/igor"));
    }

    void redirectToFurnitureList(BuildContext context) {
      context
          .read<RouterBloc>()
          .add(RedirectRouterEvent("/adam"));
    }

    return BlocListener<FurnitureBloc, FurnitureState>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: [
            IconButton(
                onPressed: () {redirectToBackgroundChange(context);},
                icon: const Icon(Icons.camera_alt_outlined)
            ),
            IconButton(
              onPressed: () {redirectToFurnitureList(context);},
              icon: const Icon(Icons.add)
            )

          ],
        ),
        body: Stack(
          children: [
            GestureDetector(
              onPanUpdate: handlePanUpdate,
              behavior: HitTestBehavior.opaque,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: backgroundImage == null
                        ? const AssetImage(
                            "lib/assets/images/CAMERA-VIEW_wo_icons.jpg")
                        : FileImage(backgroundImage!) as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            for (var i = 0; i < numberOfPiecesOfFurniture; i++)
              MyModel(xPositions[i], yPositions[i], scales[i], selectedModel == i, modelsFilePaths[i]),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                          backgroundColor:
                              isTranslateMode ? Colors.green : null,
                          child: SvgPicture.asset(
                            'lib/assets/icons/move.svg',
                            width: 24,
                            height: 24,
                          ),
                        ),
                        const SizedBox(width: 32),
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
                        const SizedBox(width: 32),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              selectModel(selectedModel - 1);
                            });
                          },
                          child: const Icon(Icons.arrow_left),
                        ),
                        const SizedBox(width: 10),
                        FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              selectModel(selectedModel + 1);
                              return;
                            });
                          },
                          child: const Icon(Icons.arrow_right),
                        ),
                      ]),
                ),
              ],
            ),
            Visibility(
              visible: isScaleMode, // Only show slider when isScaleMode is true
              child: Positioned(
                left: 16,
                bottom: 16,
                child: SizedBox(
                  width: screenWidth - 32,
                  child: Slider(
                    value: scales[selectedModel],
                    min: _minScale,
                    max: _maxScale,
                    onChanged: (value) {
                      handleScaleUpdate(value);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
                    "Currently selected model: ${selectedModel}\n${context.read<FurnitureBloc>().state.furnitureList.toString()}")),
          ],
        ),
      ),
    );
  }
}

class MyModel extends StatefulWidget {
  double xPosition;
  double yPosition;
  bool isSelected;
  double scale;
  String modelFilePath;

  MyModel(this.xPosition, this.yPosition, this.scale, this.isSelected, this.modelFilePath);

  @override
  State<MyModel> createState() => _MyModelState();
}

class _MyModelState extends State<MyModel> {
  double _scale = 0.5; // Initial scale value

  bool stateRotate = false;
  bool isTranslateMode = true;
  bool isRotateMode = false;
  bool isScaleMode = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double modelWidth = screenWidth * widget.scale;
    double modelHeight = screenHeight * widget.scale;

    double initialXPosition = (screenWidth - screenWidth) / 2;
    double initialYPosition = (screenHeight - screenHeight) / 2;
    return Positioned(
      left: widget.xPosition + initialXPosition,
      top: widget.yPosition + initialYPosition,
      child: SizedBox(
        width: modelWidth,
        height: modelHeight,
        child: Stack(
          children: [
            Container(
              width: modelWidth,
              height: modelHeight,
              decoration: BoxDecoration(
                border: Border.all(
                    color: widget.isSelected ? Colors.blue : Colors.black,
                    width: 2),
              ),
            ),
            // ModelViewer
            ModelViewer(
              src: widget.modelFilePath,
              alt: 'chair model',
              scale: '$_scale $_scale $_scale',
              cameraControls: true,
            ),
            Text(
                "  isRotateMode: ${isRotateMode}, \n  stateRotate: ${stateRotate}, \n  isSelected: ${widget.isSelected}")
          ],
        ),
      ),
    );
  }
}

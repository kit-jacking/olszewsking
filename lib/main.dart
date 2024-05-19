import 'dart:math';

import 'package:camera/camera.dart';
import 'package:decoartor/common/bloc/FurnitureBloc.dart';
import 'package:decoartor/common/bloc/RouterBloc.dart';
import 'package:decoartor/ui/adamPage/adamPage.dart';
import 'package:decoartor/ui/igorPage/cameraPage.dart';
import 'package:decoartor/ui/igorPage/igorPage.dart';
import 'package:decoartor/ui/julkaPage/julkaPage.dart';
import 'package:decoartor/ui/mainPage/mainPage.dart';
import 'package:decoartor/ui/tymonPage/tymonPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();
// Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.camera});

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    const List<Color> colorsILike = [
      Colors.yellow,
      Colors.purple,
      Colors.green,
      Colors.red,
      Colors.blue,
      Colors.pink,
      Colors.brown,
      Colors.lightGreen,
      Colors.orange
    ];
    Color mainColor = colorsILike[Random().nextInt(colorsILike.length)];

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => RouterBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => FurnitureBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
          useMaterial3: true,
        ),
        routes: {
          '/': (context) => const MainPage(title: "Login page"),
          '/igor': (context) => const IgorPage(title: "Igor page"),
          '/camera': (context) => CameraScreen(camera: camera),
          '/adam': (context) => AdamPage(title: "Adam page"),
          '/julka': (context) => const JulkaPage(title: "Julka page"),
          '/tymon': (context) => const TymonPage(title: "Ar object"),
        },
      ),
    );
  }
}

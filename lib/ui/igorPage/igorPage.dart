import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../../common/bloc/RouterBloc.dart';


class IgorPage extends StatefulWidget {
  const IgorPage({super.key, required this.title});

  final String title;

  @override
  State<IgorPage> createState() => _IgorPageState();
}

class _IgorPageState extends State<IgorPage> {

  File? _backgroundImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
              Container(
                height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: _backgroundImage == null ? const AssetImage("lib/assets/images/CAMERA-VIEW_wo_icons.jpg") : FileImage(_backgroundImage!) as ImageProvider,
                        fit: BoxFit.cover
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: _getImage, child: Text("Open image picker")),
                            ElevatedButton(onPressed: () {_openCamera(context);}, child: Text("Open camera"))
                          ],
                        ),
                    ),
            ],
          ),

    );
  }

  // Funkcja do otwarcia menu wyboru zdjęcia, które są na urządzeniu
  // Zmienia stan tła głównego ekranu
  void _getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? img = await picker.pickImage(source: ImageSource.gallery);
    if (img == null) return;
    setState(() {
      _backgroundImage = File(img.path);
    });
  }

  void _openCamera(BuildContext context) {
      context
          .read<RouterBloc>()
          .add(RedirectRouterEvent("/camera"));
  }
}


// KOD DO WEB VIEW - ALE NIE DZIALA Z WEBXR
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class IgorPage extends StatefulWidget {
//   const IgorPage({super.key});
//
//
//   @override
//   State<IgorPage> createState() => _WebViewAppState();
//
// }
//
// class _WebViewAppState extends State<IgorPage> {
//   late final WebViewController controller;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = WebViewController()
//       ..loadFlutterAsset('lib/ui/igorPage/index.html');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Igor\'s Page'),
//       ),
//       body: WebViewWidget(
//         controller: controller,
//       ),
//     );
//   }
// }
//





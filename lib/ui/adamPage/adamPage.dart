import 'package:decoartor/common/bloc/FurnitureBloc.dart';
import 'package:decoartor/common/utils/toastUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdamPage extends StatelessWidget {
  AdamPage({super.key, required this.title});

  final String title;

  final List<String> entries = <String>[
    'Krzesło Biurowe 211347',
    'MÖTH',
    'Matilda',
    'Box robot',
  ];
  final List<String> description = <String>[
    'Wybitne, obrotowe krzesło biurowe o jakże ujmującym numerze 211347. Dostępne w wielu szałowych kolorach takich jak: niebieski i różowy!',
    'Taka jakaś duża lampa wyeksportowana z painta.',
    'Pobrałem model jakiejś dziewczyny, bo był za darmo i mało ważył. Nie mam praw autorskich, ale w sumie wygląda naawet ładnie.',
    'Taki słodki robocik OMG! Założyłem konto na stronce tylko żeby go pobrać. W nazwie ma, że zrobiony przez AI.'
  ];
  final List<String> images = <String>[
    "lib/assets/images/chair-4281511_1280.png",
    "lib/assets/images/table-lamp-2320604_1280.png",
    "lib/assets/images/antique-961102_1280.png",
    "lib/assets/images/antique-961102_1280.png"
  ];
  final List<String> modelFilePaths = <String>[
    "lib/assets/objects/chair/chair_paint.glb",
    "lib/assets/objects/lamp_paint.glb",
    "lib/assets/objects/matilda.glb",
    "lib/assets/objects/box_robot_made_by_ai.glb",
  ];

  void addItem() {
    ToastUtils.showToast("Mebel dodany");
  }

  void removeItem() {
    ToastUtils.showToast("Mebel usunięty");
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FurnitureBloc, FurnitureState>(
      listener: (context, state) {
        print("Furniture list length: ${state.furnitureList.length}");
        print(state.furnitureList);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Lista mebli'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: ListView(
              children: [
                for (var i = 0; i < entries.length; i++)
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: const Border(
                        bottom: BorderSide(color: Colors.black),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Text(entries[i],
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                                  ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.circle_rounded,
                                color: Theme.of(context).primaryColor),
                            Image.asset(images[i],
                                height: MediaQuery.of(context).size.width / 4,
                                width: MediaQuery.of(context).size.width / 4
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text(
                                description[i],
                                style: const TextStyle(fontSize: 15),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Column(
                                children: [
                                  FloatingActionButton(
                                    onPressed: () {
                                      addItem();
                                      context.read<FurnitureBloc>().add(
                                          FurnitureEventAddPieceOfFurniture(
                                              modelFilePaths[i]));
                                    },
                                    backgroundColor: Colors.greenAccent,
                                    child: const Icon(Icons.add),
                                  ),
                                  SizedBox(height: 10,),
                                  FloatingActionButton(
                                    onPressed: () {
                                      context.read<FurnitureBloc>().add(
                                          FurnitureEventRemovePieceOfFurniture(
                                              modelFilePaths[i]));
                                    },
                                    backgroundColor: Colors.redAccent,
                                    child: const Icon(Icons.close),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

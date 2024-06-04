import 'package:decoartor/common/bloc/FurnitureBloc.dart';
import 'package:decoartor/common/utils/toastUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdamPage extends StatelessWidget {
  AdamPage({super.key, required this.title});

  final String title;

  final List<String> entries = <String>[
    'Krzesło drewniane',
    'Wysoka lampa',
    'Drewniana ława',
  ];
  final List<String> description = <String>[
    "To drewniane krzesło na pewno przypodoba się każdemu prowadzącemu właśnie elevator pitch. Jest dobre dla kręgosłupa.",
    "Wysoka lampa przydatna jest w każdym pomieszczeniu. Idealna do sprawdzania kolokwiów swoich studentów późnymi wieczorami.",
    "Ława z litego drewna, malowana na ciemnobrązowy kolor. Zgra się z korytarzami gmachu głównego PW, albo z ogródkiem na twojej działce!",
  ];
  final List<String> images = <String>[
    "lib/assets/images/krzeslo.png",
    "lib/assets/images/lampa.png",
    "lib/assets/images/lawka.png",

  ];
  final List<String> modelFilePaths = <String>[
    "lib/assets/objects/chair/chair_paint.glb",
    "lib/assets/objects/lamp_paint.glb",
    "lib/assets/objects/bench_dark_wood.glb",
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

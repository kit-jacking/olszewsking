import 'package:decoartor/common/utils/toastUtils.dart';
import 'package:flutter/material.dart';

class AdamPage extends StatelessWidget {
  AdamPage({super.key, required this.title});

  final String title;

  final List<String> entries = <String>[
    'Krzesło Biurowe 211347',
    'MÖTH',
    'Stehkragen'
  ];
  final List<String> description = <String>[
    'Wybitne, obrotowe krzesło biurowe o jakże ujmującym numerze 211347. Dostępne w wielu szałowych kolorach takich jak: niebieski i różowy!',
    'Klasyczna lampa stołowa z białym kloszem. Idealna do czytania kryminałów Agathy Cristie w spokojne wieczory.',
    'Niebylejaki stolik z solidnego drewna. Nadaje się doskonale do kawy albo do gry w brydża, ale żetony do pokera już się na nim nie zmieszczą.'
  ];
  final List<String> images = <String>[
    "lib/assets/chair-4281511_1280.png",
    "lib/assets/table-lamp-2320604_1280.png",
    "lib/assets/antique-961102_1280.png"
  ];

  void addItem() {
    ToastUtils.showToast("Mebel dodany");
  }

  void removeItem() {
    ToastUtils.showToast("Mebel usunięty");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    border: Border(
                      bottom: BorderSide(color: Colors.black),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.circle_rounded,
                          color: Theme.of(context).primaryColor),
                      Image.asset('${images[i]}',
                          height: MediaQuery.of(context).size.width / 4,
                          width: MediaQuery.of(context).size.width / 4),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                        width: MediaQuery.of(context).size.width / 3,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: Text('${entries[i]}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Text(
                              '${description[i]}',
                              style: TextStyle(fontSize: 15),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Column(
                          children: [
                            FloatingActionButton(
                              onPressed: () {
                                addItem();
                              },
                              backgroundColor: Colors.greenAccent,
                              child: Icon(Icons.add),
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                removeItem();
                              },
                              backgroundColor: Colors.redAccent,
                              child: Icon(Icons.close),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

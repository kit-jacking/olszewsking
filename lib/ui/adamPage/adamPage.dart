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
    'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...',
    'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...',
    'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...'
  ];
  final List<String> images = <String>[
    "lib/assets/chair-4281511_1280.png",
    "lib/assets/table-lamp-2320604_1280.png",
    "lib/assets/antique-961102_1280.png"
  ];

  void fun1() {
    int showValue = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista mebli - {title}'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                      Icon(Icons.circle_rounded),
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
                                fun1();
                              },
                              backgroundColor: Colors.greenAccent,
                              child: Icon(Icons.add),
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                fun1();
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

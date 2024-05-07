import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/bloc/RouterBloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RouterBloc, RouterState>(
      listener: (context, state) {
        if (state.currentRoute != "") {
          Navigator.pushNamed(context, state.currentRoute);
          print("Navigating to: ${state.currentRoute}");
        }
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(title),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Wybierz gdzie cię przekierować :)"),
                  SizedBox(height: 20,),
                  ElevatedButton(
                      onPressed: () => {
                            context
                                .read<RouterBloc>()
                                .add(RedirectRouterEvent("/igor"))
                          },
                      child: Text("Strona Igora")),
                  ElevatedButton(
                      onPressed: () => {
                            context
                                .read<RouterBloc>()
                                .add(RedirectRouterEvent("/adam"))
                          },
                      child: Text("Strona Adama")),
                  ElevatedButton(
                      onPressed: () => {
                            context
                                .read<RouterBloc>()
                                .add(RedirectRouterEvent("/julka"))
                          },
                      child: Text("Strona Julki")),
                ],
              ),
            ),
          )),
    );
  }
}

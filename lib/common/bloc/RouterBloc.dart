import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouterState {
  String currentRoute;

  RouterState(String this.currentRoute);
}


class RouterEvent {
  String route;

  RouterEvent(String this.route);
}

class RedirectRouterEvent extends RouterEvent{
  RedirectRouterEvent(String route): super(route);
}

class RouterBloc extends Bloc<RouterEvent, RouterState> {
  RouterBloc() : super(RouterState("/")) {

    on<RedirectRouterEvent>((event, emit) async {
      RouterState newState = RouterState(event.route);
      emit(newState);
    });
  }
}

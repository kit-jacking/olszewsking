import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

enum StateOne { unknown }


class OneEvent {
  OneEvent();
}

class BlocOne extends Bloc<OneEvent, StateOne> {
  BlocOne() : super(StateOne.unknown) {

    on<OneEvent>((event, emit) async {
    });
  }
}

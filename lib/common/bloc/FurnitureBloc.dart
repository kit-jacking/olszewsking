import 'package:flutter_bloc/flutter_bloc.dart';

class FurnitureState {
  List<String> furnitureList = [];
}


class FurnitureEvent {}

class FurnitureEventAddPieceOfFurniture extends FurnitureEvent {
  String pieceOfFurnitureFilePath;

  FurnitureEventAddPieceOfFurniture(this.pieceOfFurnitureFilePath);
}

class FurnitureEventRemovePieceOfFurniture extends FurnitureEvent {
  String pieceOfFurnitureFilePath;

  FurnitureEventRemovePieceOfFurniture(this.pieceOfFurnitureFilePath);
}

class FurnitureBloc extends Bloc<FurnitureEvent, FurnitureState> {
  FurnitureBloc() : super(FurnitureState()) {
    on<FurnitureEventAddPieceOfFurniture>((event, emit) async {
      FurnitureState newState = FurnitureState();
      newState.furnitureList = state.furnitureList;
      newState.furnitureList.add(event.pieceOfFurnitureFilePath);

      emit(newState);
    });

    on<FurnitureEventRemovePieceOfFurniture>((event, emit) async {
      FurnitureState newState = FurnitureState();
      newState.furnitureList = state.furnitureList;
      newState.furnitureList.removeWhere((element) => element == event.pieceOfFurnitureFilePath);

      emit(newState);
    });
  }
}

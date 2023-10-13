import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../domain/models/town.dart';
import '../../../domain/repository/town_repository.dart';

part 'towns_event.dart';
part 'towns_state.dart';

class TownsBloc extends Bloc<TownsEvent, TownsState> {
  final TownRepository repository;

  TownsBloc({required this.repository}) : super(TownsState.initial()) {
    on<GetTownsEvent>(_getTowns);
  }

  void _getTowns(GetTownsEvent event, Emitter<TownsState> emit) async {
    emit(state.copyWith(status: TownStatus.loading));
    try {
      List<Town> towns = await repository.getTowns();
      emit(state.copyWith(towns: towns, status: TownStatus.success));
    } catch (e) {
      String errorMessage = e.toString().replaceAll('Exception: ', '');
      emit(state.copyWith(error: errorMessage, status: TownStatus.error));
    }
  }

}

import 'dart:async';
import 'package:app/domain/models/centers.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import '../../../domain/repository/center_repository.dart';

part 'centers_event.dart';
part 'centers_state.dart';

class CentersBloc extends Bloc<CentersEvent, CentersState> {
  final CenterRepository repository;

  CentersBloc({required this.repository}) : super(CentersState.initial()) {
    on<GetAllCenters>(_getAllCenters);
    on<AddCenter>(_addCenter);
  }

  void _getAllCenters(GetAllCenters event, Emitter<CentersState> emit) async {
    emit(state.copyWith(status: CentersStatus.loading));
    try {
      final centers = await repository.getCenters();
      emit(state.copyWith(status: CentersStatus.success, centers: centers));
    } catch (e) {
      String errorMessage = e.toString().replaceAll('Exception: ', '');
      emit(state.copyWith(error: errorMessage, status: CentersStatus.error));
    }
  }

  void _addCenter(AddCenter event, Emitter<CentersState> emit) async {
    emit(state.copyWith(status: CentersStatus.loading));
    try {
      await repository.addCenter(event.center);
      emit(state.copyWith(status: CentersStatus.successAdd));
    } catch (e) {
      String errorMessage = e.toString().replaceAll('Exception: ', '');
      emit(state.copyWith(error: errorMessage, status: CentersStatus.error));
    }
  }
}

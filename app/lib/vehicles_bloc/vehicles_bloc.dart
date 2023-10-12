import 'package:app/models/vehicles.dart';
import 'package:app/repository/vehicles_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'vehicles_event.dart';
part 'vehicles_state.dart';

class VehiclesBloc extends Bloc<VehiclesEvent, VehiclesState> {
  final VehiclesRepository repository;

  VehiclesBloc({required this.repository}) : super(VehiclesState()) {
    on<GetAllVehicles>((event, emit) async {
      try {
        emit(state.copyWith(status: VehiclesStatus.loading));
        await for (var vehicles in repository.getAllVehicles()) {
          emit(state.copyWith(vehicles: vehicles, status: VehiclesStatus.success));
        }
      } catch (e) {
        String errorMessage = e.toString().replaceAll('Exception: ', '');
        emit(state.copyWith(error: errorMessage, status: VehiclesStatus.error));
      }
    });

    on<AddVehicle>((event, emit) async {
      emit(state.copyWith(status: VehiclesStatus.loading));
      try {
        await repository.addVehicle(event.vehicle);
        emit(state.copyWith(status: VehiclesStatus.editSuccess));
      } catch (e) {
        String errorMessage = e.toString().replaceAll('Exception: ', '');
        emit(state.copyWith(error: errorMessage, status: VehiclesStatus.error));
      }
    });

    on<EditVehicle>((event, emit) async {
      emit(state.copyWith(status: VehiclesStatus.loading));
      try {
        await repository.editVehicle(event.vehicle);
        emit(state.copyWith(status: VehiclesStatus.editSuccess));
      } catch (e) {
        String errorMessage = e.toString().replaceAll('Exception: ', '');
        emit(state.copyWith(error: errorMessage, status: VehiclesStatus.error));
      }
    });

    on<DetailVehicle>((event, emit) async {
      emit(state.copyWith(status: VehiclesStatus.loading));
      try {
        await repository.detailVehicle(event.id);
        emit(state.copyWith(status: VehiclesStatus.success));
      } catch (e) {
        String errorMessage = e.toString().replaceAll('Exception: ', '');
        emit(state.copyWith(error: errorMessage, status: VehiclesStatus.error));
      }
    });
  }
}

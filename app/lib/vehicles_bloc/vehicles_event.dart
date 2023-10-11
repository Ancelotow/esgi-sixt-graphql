part of 'vehicles_bloc.dart';

@immutable
abstract class VehiclesEvent {}

class GetAllVehicles extends VehiclesEvent {
  GetAllVehicles();
}

class AddVehicle extends VehiclesEvent {
  final Vehicle vehicle;

  AddVehicle({
    required this.vehicle,
  });
}

class EditVehicle extends VehiclesEvent {
  final Vehicle vehicle;

  EditVehicle({
    required this.vehicle,
  });
}

class DetailVehicle extends VehiclesEvent {
  final String id;

  DetailVehicle({
    required this.id,
  });
}

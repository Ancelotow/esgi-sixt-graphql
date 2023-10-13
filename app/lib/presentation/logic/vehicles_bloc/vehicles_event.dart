part of 'vehicles_bloc.dart';

@immutable
abstract class VehiclesEvent {}

class GetAllVehicles extends VehiclesEvent {
  GetAllVehicles();
}

class GetFilterVehicles extends VehiclesEvent {
  final String maxKm;
  final String minPlace;

  GetFilterVehicles({
    required this.maxKm,
    required this.minPlace,
  });
}

class GetBrandVehicles extends VehiclesEvent {
  final String brand;

  GetBrandVehicles({
    required this.brand,
  });
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

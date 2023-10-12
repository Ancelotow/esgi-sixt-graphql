part of 'vehicles_bloc.dart';

enum VehiclesStatus {
  initial,
  loading,
  success,
  editSuccess,
  error,
}

class VehiclesState {
  final VehiclesStatus status;
  final List<Vehicle> vehicles;
  final String error;

  VehiclesState({
    this.status = VehiclesStatus.initial,
    this.vehicles = const [],
    this.error = '',
  });

  VehiclesState copyWith({
    VehiclesStatus? status,
    List<Vehicle>? vehicles,
    String? error,
  }) {
    return VehiclesState(
      status: status ?? this.status,
      vehicles: vehicles ?? this.vehicles,
      error: error ?? this.error,
    );
  }
}
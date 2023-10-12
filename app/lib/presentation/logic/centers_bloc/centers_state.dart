part of 'centers_bloc.dart';

enum CentersStatus {
  initial,
  loading,
  success,
  successAdd,
  error,
}

class CentersState {
  final CentersStatus status;
  final List<CenterVehicle> centers;
  final String error;

  CentersState({
    this.status = CentersStatus.initial,
    this.centers = const [],
    this.error = '',
  });

  factory CentersState.initial() => CentersState();

  CentersState copyWith({
    CentersStatus? status,
    List<CenterVehicle>? centers,
    String? error,
  }) {
    return CentersState(
      status: status ?? this.status,
      centers: centers ?? this.centers,
      error: error ?? this.error,
    );
  }
}

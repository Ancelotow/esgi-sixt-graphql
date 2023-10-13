part of 'colors_bloc.dart';

enum ColorsStatus {
  initial,
  loading,
  success,
  error,
}

class ColorsState {
  final ColorsStatus status;
  final List<VehicleColor> colors;
  final String error;

  ColorsState({
    this.status = ColorsStatus.initial,
    this.colors = const [],
    this.error = '',
  });

  factory ColorsState.initial() => ColorsState();

  ColorsState copyWith({
    ColorsStatus? status,
    List<VehicleColor>? colors,
    String? error,
  }) {
    return ColorsState(
        status: status ?? this.status,
        colors: colors ?? this.colors,
        error: error ?? this.error,
    );
  }
}

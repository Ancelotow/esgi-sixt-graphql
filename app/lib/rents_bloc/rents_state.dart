part of 'rents_bloc.dart';

enum RentsStatus {
  initial,
  loading,
  success,
  editSuccess,
  error,
}

class RentsState {
  final RentsStatus status;
  final List<Rent> rents;
  final String error;

  RentsState({
    this.status = RentsStatus.initial,
    this.rents = const [],
    this.error = '',
  });

  RentsState copyWith({
    RentsStatus? status,
    List<Rent>? rents,
    String? error,
  }) {
    return RentsState(
        status: status ?? this.status,
        rents: rents ?? this.rents,
        error: error ?? this.error,
    );
  }
}

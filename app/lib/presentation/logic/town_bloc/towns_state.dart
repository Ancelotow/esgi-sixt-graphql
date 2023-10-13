part of 'towns_bloc.dart';

enum TownStatus {
  initial,
  loading,
  success,
  error,
}

class TownsState {
  final TownStatus status;
  final List<Town> towns;
  final String error;

  TownsState({
    this.status = TownStatus.initial,
    this.towns = const [],
    this.error = '',
  });

  factory TownsState.initial() => TownsState();

  TownsState copyWith({
    TownStatus? status,
    List<Town>? towns,
    String? error,
  }) {
    return TownsState(
        status: status ?? this.status,
        towns: towns ?? this.towns,
        error: error ?? this.error,
    );
  }
}

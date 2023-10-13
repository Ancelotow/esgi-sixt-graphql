part of 'models_bloc.dart';

enum ModelStatus {
  initial,
  loading,
  success,
  error,
}

class ModelsState {
  final ModelStatus status;
  final List<BrandModel> models;
  final String error;

  ModelsState({
    this.status = ModelStatus.initial,
    this.models = const [],
    this.error = '',
  });

  factory ModelsState.initial() => ModelsState();

  ModelsState copyWith({
    ModelStatus? status,
    List<BrandModel>? models,
    String? error,
  }) {
    return ModelsState(
        status: status ?? this.status,
        models: models ?? this.models,
        error: error ?? this.error,
    );
  }
}

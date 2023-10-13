import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/models/brand_model.dart';
import '../../../domain/repository/brand_model_repository.dart';

part 'models_event.dart';
part 'models_state.dart';

class ModelsBloc extends Bloc<ModelsEvent, ModelsState> {
  final BrandModelRepository repository;

  ModelsBloc({required this.repository}) : super(ModelsState.initial()) {
    on<GetModelsEvent>(_getModels);
  }

  void _getModels(GetModelsEvent event, Emitter<ModelsState> emit) async {
    emit(state.copyWith(status: ModelStatus.loading));
    try {
      List<BrandModel> models = await repository.getAllBrands();
      emit(state.copyWith(models: models, status: ModelStatus.success));
    } catch (e) {
      String errorMessage = e.toString().replaceAll('Exception: ', '');
      emit(state.copyWith(error: errorMessage, status: ModelStatus.error));
    }
  }
}

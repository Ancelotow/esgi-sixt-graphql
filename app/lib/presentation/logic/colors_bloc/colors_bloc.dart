import 'dart:async';
import 'package:app/domain/models/color.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/repository/color_repository.dart';

part 'colors_event.dart';
part 'colors_state.dart';

class ColorsBloc extends Bloc<ColorsEvent, ColorsState> {
  final ColorRepository repository;

  ColorsBloc({required this.repository}) : super(ColorsState.initial()) {
    on<GetColorsEvent>(_getColors);
  }

  void _getColors(GetColorsEvent event, Emitter<ColorsState> emit) async {
    emit(state.copyWith(status: ColorsStatus.loading));
    try {
      List<VehicleColor> colors = await repository.getColors();
      emit(state.copyWith(colors: colors, status: ColorsStatus.success));
    } catch (e) {
      String errorMessage = e.toString().replaceAll('Exception: ', '');
      print(e);
      emit(state.copyWith(error: errorMessage, status: ColorsStatus.error));
    }
  }

}

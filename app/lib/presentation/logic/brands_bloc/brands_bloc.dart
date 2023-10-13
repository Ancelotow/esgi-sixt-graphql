import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import '../../../domain/models/brand.dart';
import '../../../domain/repository/brand_repository.dart';

part 'brands_event.dart';
part 'brands_state.dart';

class BrandsBloc extends Bloc<BrandsEvent, BrandsState> {
  final BrandRepository repository;

  BrandsBloc({required this.repository}) : super(BrandsState.initial()) {
    on<GetAllBrands>(_getAllBrands);
  }

  void _getAllBrands(GetAllBrands event, Emitter<BrandsState> emit) async {
    emit(state.copyWith(status: BrandsStatus.loading));
    try {
      final brands = await repository.getBrands();
      emit(state.copyWith(status: BrandsStatus.success, brands: brands));
    } catch (e) {
      String errorMessage = e.toString().replaceAll('Exception: ', '');
      emit(state.copyWith(error: errorMessage, status: BrandsStatus.error));
    }
  }
}

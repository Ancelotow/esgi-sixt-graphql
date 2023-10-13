part of 'brands_bloc.dart';

enum BrandsStatus {
  initial,
  loading,
  success,
  error,
}

class BrandsState {
  final BrandsStatus status;
  final List<Brand> brands;
  final String error;

  BrandsState({
    this.status = BrandsStatus.initial,
    this.brands = const [],
    this.error = '',
  });

  factory BrandsState.initial() => BrandsState();

  BrandsState copyWith({
    BrandsStatus? status,
    List<Brand>? brands,
    String? error,
  }) {
    return BrandsState(
        status: status ?? this.status,
        brands: brands ?? this.brands,
        error: error ?? this.error,
    );
  }
}
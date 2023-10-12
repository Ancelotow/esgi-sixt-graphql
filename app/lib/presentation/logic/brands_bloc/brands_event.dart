part of 'brands_bloc.dart';

@immutable
abstract class BrandsEvent {}

class GetAllBrands extends BrandsEvent {
  GetAllBrands();
}
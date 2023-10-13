import '../domain/models/brand_model.dart';

abstract class BrandModelDataSource {
  Future<List<BrandModel>> getAllBrands();
}
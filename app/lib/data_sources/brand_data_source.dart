import 'package:app/domain/models/brand.dart';

abstract class BrandDataSource {

  Future<List<Brand>> getAllBrands();

}
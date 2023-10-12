import '../../data_sources/brand_data_source.dart';
import '../models/brand.dart';

class BrandRepository {
  final BrandDataSource brandDataSource;

  BrandRepository({required this.brandDataSource});

  Future<List<Brand>> getBrands() => brandDataSource.getAllBrands();
}

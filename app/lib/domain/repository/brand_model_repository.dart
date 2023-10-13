import '../../data_sources/brand_model_data_source.dart';
import '../models/brand_model.dart';

class BrandModelRepository {
  final BrandModelDataSource brandModelDataSource;

  BrandModelRepository({required this.brandModelDataSource});

  Future<List<BrandModel>> getAllBrands() async => brandModelDataSource.getAllBrands();

}
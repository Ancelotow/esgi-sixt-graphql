import 'package:app/domain/models/centers.dart';
import '../../data_sources/center_data_source.dart';

class CenterRepository {
  final CenterDataSource centerDataSource;

  CenterRepository({required this.centerDataSource});

  Future<List<CenterVehicle>> getCenters() => centerDataSource.getCenters();

  Future<CenterVehicle> addCenter(CenterVehicle center) => centerDataSource.addCenter(center);
}
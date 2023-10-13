import '../../data_sources/color_data_source.dart';
import '../models/color.dart';

class ColorRepository {
  final ColorDataSource colorDataSource;

  ColorRepository({
    required this.colorDataSource,
  });

  Future<List<VehicleColor>> getColors() => colorDataSource.getColors();
}
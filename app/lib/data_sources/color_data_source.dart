import '../domain/models/color.dart';

abstract class ColorDataSource {
  Future<List<VehicleColor>> getColors();
}
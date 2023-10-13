import 'package:app/domain/models/vehicles.dart';

abstract class VehiclesDataSource {
  Stream<List<Vehicle>> getAllVehicles();

  Future<String> addVehicle(Vehicle vehicle);

  Future<void> editVehicle(Vehicle vehicle);

  Future<Vehicle> detailVehicle(String id);

  Stream<List<Vehicle>> getVehiclesFilter(String maxKm, String minPlace);

  Stream<List<Vehicle>> getVehiclesBrand(String brand);
}
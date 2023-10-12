import 'package:app/models/vehicles.dart';

abstract class VehiclesDataSource {
  Stream<List<Vehicle>> getAllVehicles();

  Future<String> addVehicle(Vehicle vehicle);

  Future<void> editVehicle(Vehicle vehicle);

  Future<Vehicle> detailVehicle(String id);
}
import 'package:app/data_sources/vehicles_data_source.dart';
import 'package:app/domain/models/vehicles.dart';

class VehiclesRepository {
  final VehiclesDataSource vehiclesDataSource;

  VehiclesRepository({
    required this.vehiclesDataSource,
  });

  Stream<List<Vehicle>> getAllVehicles() {
    return vehiclesDataSource.getAllVehicles();
  }

  Stream<List<Vehicle>> getVehiclesFilter(String maxKm, String minPlace) {
    return vehiclesDataSource.getVehiclesFilter(maxKm, minPlace);
  }

  Future<void> editVehicle(Vehicle vehicle) {
    return vehiclesDataSource.editVehicle(vehicle);
  }

  Future<String> addVehicle(Vehicle vehicle){
    return vehiclesDataSource.addVehicle(vehicle);
  }

  Future<Vehicle> detailVehicle(String id){
    return vehiclesDataSource.detailVehicle(id);
  }
}
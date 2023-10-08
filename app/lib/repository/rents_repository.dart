import 'package:app/data_sources/rents_data_source.dart';
import 'package:app/models/rents.dart';

class RentsRepository {
  final RentsDataSource rentDataSource;

  RentsRepository({
    required this.rentDataSource,
  });

  Future<List<Rent>> getAllRents() {
    return rentDataSource.getAllRents();
  }

  Future<void> editRent(Rent rent) {
    return rentDataSource.editRent(rent);
  }

  Future<String> addRent(Rent rent){
    return rentDataSource.addRent(rent);
  }

  Future<Rent> detailRent(String id){
    return rentDataSource.detailRent(id);
  }
}
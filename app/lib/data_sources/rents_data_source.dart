import 'package:app/models/rents.dart';

abstract class RentsDataSource {

  Future<List<Rent>> getAllRents();

  Future<void> editRent(Rent rent);

  Future<String> addRent(Rent rent);

  Future<Rent> detailRent(String id);
}
import '../domain/models/town.dart';

abstract class TownDataSource {
  Future<List<Town>> getTowns();
}
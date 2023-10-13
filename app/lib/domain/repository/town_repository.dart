import '../../data_sources/town_data_source.dart';
import '../models/town.dart';

class TownRepository {
  final TownDataSource townDataSource;

  TownRepository({required this.townDataSource});

  Future<List<Town>> getTowns() async => townDataSource.getTowns();
}
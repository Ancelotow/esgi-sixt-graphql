import 'package:app/data_sources/rents_data_source.dart';
import 'package:app/domain/models/rents.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ApiRentsDataSource extends RentsDataSource {
  final ValueNotifier<GraphQLClient> client;

  ApiRentsDataSource(this.client);

  @override
  Future<String> addRent(Rent rent) {
    // TODO: implement addRent
    throw UnimplementedError();
  }

  @override
  Future<Rent> detailRent(String id) {
    // TODO: implement detailRent
    throw UnimplementedError();
  }

  @override
  Future<void> editRent(Rent rent) {
    // TODO: implement editRent
    throw UnimplementedError();
  }

  @override
  Future<List<Rent>> getAllRents() {
    // TODO: implement getAllRents
    throw UnimplementedError();
  }
}
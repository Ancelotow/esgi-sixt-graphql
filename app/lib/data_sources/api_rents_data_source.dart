import 'package:app/data_sources/rents_data_source.dart';
import 'package:app/models/rents.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ApiRentsDataSource extends RentsDataSource {
  late final HttpLink httpLink;
  late final ValueNotifier<GraphQLClient> client;

  ApiRentsDataSource() {
    httpLink = HttpLink("http://localhost:4000/graphql");
    client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      ),
    );
  }

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
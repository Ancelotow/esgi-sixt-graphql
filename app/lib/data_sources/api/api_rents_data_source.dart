import 'package:app/data_sources/rents_data_source.dart';
import 'package:app/domain/models/rents.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ApiRentsDataSource extends RentsDataSource {


  @override
  Future<String> addRent(Rent rent) async{
    const String addRent = r'''
    mutation CreateRent($nbDays: Int!, $amountExcluding: Int!, $vatRate: Float!, $vehicleId: Int!, $status: Status!){
      createRent(input: {nbDays: $nbDays, amountExcluding: $amountExcluding, vatRate: $vatRate, vehicleId: $vehicleId, status: $status}) {
        rent{
          id
          amountExcluding
        }
      }
    }
    ''';

    final QueryOptions options = QueryOptions(
      document: gql(addRent),
      variables: {
        'nbDays': rent.nbDays,
        'amountExcluding': rent.amountExcluding,
        'vatRate': 0.2,
        'vehicleId': rent.vehicleId,
        'status': rent.status,
      },
    );

    final QueryResult result = await client.value.query(options);

    if (result.hasException) {
      throw Exception('Erreur GraphQL: ${result.exception.toString()}');
    } else {
      final String idRent = result.data!['createRent']['rent']['amountExcluding'];
      return idRent;
    }
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

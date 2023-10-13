import 'package:app/data_sources/center_data_source.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../domain/models/centers.dart';
import '../../domain/models/session.dart';

class ApiCenterDataSource implements CenterDataSource {

  ApiCenterDataSource();

  @override
  Future<CenterVehicle> addCenter(CenterVehicle center) async {
    const String query = r'''
    mutation AddCenter($name: String!, $address: String!, $inseeCode: String!){
      addCenter(input: {name: $name, address: $address, inseeCode: $inseeCode}) {
        center{
          id
          name
          address
          town {
            inseeCode
            zipCode
            name
          }
        }
      }
    }
    ''';

    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {
        'name': center.name,
        'address': center.address,
        'inseeCode': center.town!.inseeCode,
      },
    );

    final QueryResult result = await Session.instance().getGraphQLClient().value.query(options);

    if (result.hasException) {
      throw Exception('Erreur GraphQL: ${result.exception.toString()}');
    } else {
      final centerJson = result.data!['addCenter']['center'] as dynamic;
      return CenterVehicle.fromJson(centerJson);
    }
  }

  @override
  Future<List<CenterVehicle>> getCenters() async {
    const String query = r'''
    query {
        centers{
          id
          name
          address
          town {
            inseeCode
            zipCode
            name
          }
        }
    }
    ''';
    final QueryOptions options = QueryOptions(
      document: gql(query),
    );
    final QueryResult result = await Session.instance().getGraphQLClient().value.query(options);
    if (result.hasException) {
      throw Exception('Erreur GraphQL: ${result.exception.toString()}');
    } else {
      final centersDto = result.data!['centers'] as List<dynamic>;
      return centersDto.map((center) => CenterVehicle.fromJson(center)).toList();
    }
  }
}
import 'package:app/data_sources/rents_data_source.dart';
import 'package:app/domain/models/rents.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../domain/models/session.dart';

class ApiRentsDataSource extends RentsDataSource {


  @override
  Future<String> addRent(Rent rent) async{
    const String addRent = r'''
    mutation CreateRent($nbDays: Int!, $amountExcluding: Int!, $vatRate: Float!, $vehicleId: Int!, $status: Status!){
      createRent(input: {nbDays: $nbDays, amountExcluding: $amountExcluding, vatRate: $vatRate, vehicleId: $vehicleId, status: $status}) {
        rent{
          id
          nbDays
          amountExcluding
          vatRate
          rentAt
          createdAt
          vehicle {
            id
            transmission
            nbPlaces
            amountExcluding
            model {
              id
              name
              releaseYear
              brand {
                id
                name
                logoUri
              }
            }
            center {    
              id     
              name
              address 
              town {
                inseeCode
                zipCode
                name
              }
            }
            imageUri
            kilometrage
          }
          status
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

    final QueryResult result = await Session.instance().getGraphQLClient().value.query(options);

    if (result.hasException) {
      throw Exception('Erreur GraphQL: ${result.exception.toString()}');
    } else {
      final String idRent = result.data!['createRent']['rent']['id'];
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
  Future<List<Rent>> getAllRents() async {
    const String query = r'''
    query {
      rents {
        edges {
          node {
            id
            nbDays
            amountExcluding
            vatRate
            rentAt
            createdAt
            vehicle {
              id
              transmission
              nbPlaces
              amountExcluding
              model {
                id
                name
                releaseYear
                brand {
                  id
                  name
                  logoUri
                }
              }
              center {    
                id     
                name
                address 
                town {
                  inseeCode
                  zipCode
                  name
                }
              }
              imageUri
              kilometrage
            }
            status
          }
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
      final rentsDto = result.data!['rents']['edges'] as List<dynamic>;
      return rentsDto.map((node) => Rent.fromJson(node['node'])).toList();
    }
  }
}

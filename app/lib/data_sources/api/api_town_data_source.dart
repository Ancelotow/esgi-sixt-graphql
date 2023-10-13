import 'package:app/domain/models/town.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../domain/models/session.dart';
import '../town_data_source.dart';

class ApiTownDataSource implements TownDataSource {

  @override
  Future<List<Town>> getTowns() async {
    const String query = r'''
    query {
        towns {
          inseeCode
          zipCode
          name
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
      final townDto = result.data!['towns'] as List<dynamic>;
      return townDto.map((town) => Town.fromJson(town)).toList();
    }
  }


}
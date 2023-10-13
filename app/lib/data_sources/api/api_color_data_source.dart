import 'package:app/domain/models/color.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../domain/models/session.dart';
import '../color_data_source.dart';

class ApiColorDataSource implements ColorDataSource {

  @override
  Future<List<VehicleColor>> getColors() async {
    const String query = r'''
    query {
        colors {
            id
            name
            hex
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
      final colorsDto = result.data!['colors'] as List<dynamic>;
      return colorsDto.map((color) => VehicleColor.fromJson(color)).toList();
    }
  }


}

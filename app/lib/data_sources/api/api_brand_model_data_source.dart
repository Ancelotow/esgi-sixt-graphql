import 'package:app/domain/models/brand_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../domain/models/session.dart';
import '../brand_model_data_source.dart';

class ApiBrandModelDataSource implements BrandModelDataSource {
  @override
  Future<List<BrandModel>> getAllBrands() async {
    const String query = r'''
    query {
        models {
            id
            name
            releaseYear
            brand {
                id
                name
                logoUri
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
      final brandsDto = result.data!['models'] as List<dynamic>;
      return brandsDto.map((model) => BrandModel.fromJson(model)).toList();
    }
  }


}

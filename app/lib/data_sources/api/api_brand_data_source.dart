import 'package:app/data_sources/brand_data_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../domain/models/brand.dart';

class ApiBrandDataSource implements BrandDataSource {
  final ValueNotifier<GraphQLClient> client;

  ApiBrandDataSource(this.client);

  @override
  Future<List<Brand>> getAllBrands() async {
    const String query = r'''
    query {
        brands {
            id
            name
            logoUri
        }
    }
    ''';
    final QueryOptions options = QueryOptions(
      document: gql(query),
    );
    final QueryResult result = await client.value.query(options);
    if (result.hasException) {
      throw Exception('Erreur GraphQL: ${result.exception.toString()}');
    } else {
      final brandsDto = result.data!['brands'] as List<dynamic>;
      return brandsDto.map((brand) => Brand.fromJson(brand)).toList();
    }
  }
}

import 'package:app/data_sources/brand_data_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../domain/models/brand.dart';

class ApiBrandDataSource implements BrandDataSource {
  late final HttpLink httpLink;
  late final ValueNotifier<GraphQLClient> client;

  ApiBrandDataSource() {
    httpLink = HttpLink('${dotenv.env["API_BASE_URI"]}/graphql');
    client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      ),
    );
  }

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
      final brandsDti = result.data!['brands'];
      //result.map((e) => print(e));

      return [];
    }
  }
}

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:malabis_app/util/gql_queries.dart';

class GraphQLService {
  final GraphQLClient client;

  GraphQLService(this.client);

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    final result = await client.query(
      QueryOptions(
        document: gql(GQLQuries.listProductsQuery),
      ),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final data = result.data?['listProductsFilter'] as List<dynamic>?;
    if (data == null) return [];

    return data.cast<Map<String, dynamic>>();
  }
}

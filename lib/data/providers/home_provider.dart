import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:malabis_app/data/providers/init_provider.dart';
import 'package:malabis_app/util/gql_mutations.dart';
import 'package:malabis_app/util/gql_queries.dart';

class HomeProvider {
  final provider = InitProvider();
  final GraphQLClient client;
  HomeProvider(this.client);

  /*Future<QueryResult> getProductList() async {
    final options = QueryOptions(
      document: gql(listProductsQuery),
    );
    return await client.query(options);
  }*/


  Future<QueryResult> getCategoriesList() async {
    QueryOptions options = QueryOptions(document: gql(GQLQuries.categoryList));

    final result = await provider.client.query(options);

    return result;
  }

  Future<QueryResult> getBannerImages() async {
    QueryOptions options = QueryOptions(document: gql(GQLQuries.bannerQuery));

    final result = await provider.client.query(options);
    print("Banner API Result: ${result.data}");

    return result;
  }

  Future<QueryResult> getProductList(Map<String, dynamic> variable) async {
    QueryOptions options = QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        document: gql(variable['customer_id'] == null || variable['customer_id'] == 0
    ? GQLQuries.findWithoutID
    : GQLQuries.findByCategory),
        variables: variable);
    print("Product API Result: ${options.variables}");

    if (!variable.containsKey('category_id') || variable['category_id'] == null) {
    throw Exception("Missing or invalid 'category_id'");
  }
  if (!variable.containsKey('customer_id')) {
    variable['customer_id'] = 0; // Default to 0 if not provided
  }
    final result = await provider.client.query(options);

    return result;
  }

  Future<QueryResult> searchProducts(Map<String, dynamic> variable) async {
    QueryOptions options =
        QueryOptions(document: gql(GQLQuries.searchQuery), variables: variable);

    final result = await provider.client.query(options);

    return result;
  }

  Future<QueryResult> getSuggestions(Map<String, dynamic> variable) async {
    QueryOptions options =
        QueryOptions(document: gql(GQLQuries.searchQuery), variables: variable);

    final result = await provider.client.query(options);

    return result;
  }

  Future<QueryResult> addToFav(Map<String, dynamic> variable) async {
    QueryOptions options = QueryOptions(
        document: gql(GQLMutation.addtoFavQuery), variables: variable);

    final result = await provider.client.query(options);

    return result;
  }

  Future<QueryResult> fetchFav(Map<String, dynamic> variable) async {
    QueryOptions options = QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        document: gql(GQLQuries.fetchFavQuery), variables: variable);

    final result = await provider.client.query(options);

    return result;
  }
}

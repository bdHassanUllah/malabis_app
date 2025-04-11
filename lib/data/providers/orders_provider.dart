import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:malabis_app/data/providers/init_provider.dart';

class OrdersProvider {
  final provider = InitProvider();

  Future<QueryResult> getPendingOrders(String query, variable) async {
    QueryOptions options = QueryOptions(
      document: gql(query),
      variables: variable,
      fetchPolicy: FetchPolicy.networkOnly,
    );
    return await provider.client.query(options);
  }

  Future<QueryResult> getDeliveredOrders(String query, variable) async {
    QueryOptions options = QueryOptions(
      document: gql(query),
      variables: variable,
      fetchPolicy: FetchPolicy.networkOnly,
    );
    return await provider.client.query(options);
  }

  Future<QueryResult> getCanceledOrders(String query, variable) async {
    QueryOptions options = QueryOptions(
      document: gql(query),
      variables: variable,
      fetchPolicy: FetchPolicy.networkOnly,
    );
    return await provider.client.query(options);
  }

  Future<QueryResult> trackOrder(String query, variable) async {
    QueryOptions options = QueryOptions(
      document: gql(query),
      variables: variable,
      fetchPolicy: FetchPolicy.networkOnly,
    );
    return await provider.client.query(options);
  }
}
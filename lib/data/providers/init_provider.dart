import 'dart:convert';
import 'package:graphql_flutter/graphql_flutter.dart';

class InitProvider {
  late GraphQLClient client;

  InitProvider() {
    // WooCommerce consumer credentials
    final String username = 'ck_ed96ae2337106d3d2ebdb76c6b2649f276020e59';
    final String password = 'cs_7e884138b2555a93783d20ca78e7aa78bb4f66f4';

    // Base64 encode the credentials for Basic Auth
    final String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    // Your hosted GraphQL backend endpoint
    final HttpLink httpLink = HttpLink(
      'https://malabis.pk/graphql',
      defaultHeaders: {
        'Authorization': basicAuth,
      },
    );

    // GraphQL client initialization
    client = GraphQLClient(
      cache: GraphQLCache(store: InMemoryStore()),
      link: httpLink,
    );
  }

  GraphQLClient getClient() => client;
}

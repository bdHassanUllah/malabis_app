// lib/api/wordpress_api.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:malabis_app/data/model/product_model.dart.dart';

class WordPressApi {
  final String baseUrl = 'https://malabis.pk/wp-json/wc/v3';

  // Basic Auth credentials
  final String consumerKey = 'ck_ed96ae2337106d3d2ebdb76c6b2649f276020e59';
  final String consumerSecret = 'cs_7e884138b2555a93783d20ca78e7aa78bb4f66f4';

  // Encode credentials in base64 for Basic Auth
  Map<String, String> get headers {
    String credentials = '$consumerKey:$consumerSecret';
    String encoded = base64Encode(utf8.encode(credentials));
    return {
      'Authorization': 'Basic $encoded',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/products'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  }
}

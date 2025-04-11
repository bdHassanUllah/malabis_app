import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:malabis_app/data/providers/home_provider.dart';
import 'package:malabis_app/data/providers/init_provider.dart';

class HomeRepository {
  final homeProvider = HomeProvider(InitProvider().client);

  Future<QueryResult> getCategoriesList() async {
    final result = homeProvider.getCategoriesList();
    return result;
  }
  Future<QueryResult> getBannerImages() async {
    final result = homeProvider.getBannerImages();
    return result;
  }

  Future<QueryResult> getProductsList(Map<String, dynamic> varibale) async {
    final result = homeProvider.getProductList(varibale);
    return result;
  }

  Future<QueryResult> searchProducts(Map<String, dynamic> varibale) async {
    final result = homeProvider.searchProducts(varibale);
    return result;
  }

  Future<QueryResult> getSuggestions(Map<String, dynamic> varibale) async {
    final result = homeProvider.getSuggestions(varibale);
    return result;
  }

  Future<QueryResult> addToFav(Map<String, dynamic> varibale) async {
    final result = homeProvider.addToFav(varibale);
    return result;
  }

  Future<QueryResult> fetchFav(Map<String, dynamic> varibale) async {
    final result = homeProvider.fetchFav(varibale);
    return result;
  }
}

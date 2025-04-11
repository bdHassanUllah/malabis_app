import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:malabis_app/data/model/favorite_model.dart';
import 'package:malabis_app/data/model/product_model.dart';

class HomeState {
  final QueryResult? productResult;
  final QueryResult? categoryResult;
  final QueryResult? searchResult;
  final int? index;
  final String categoryState;
  final String? productState;
  final String? search;
  final String? searchState;
  final QueryResult? searchSuggestions;
  final QueryResult? favResult;
  final String? favState;
  final List<dynamic>? bannerImagesList;
  final String? bannerImageStatus;
  final List<ProductModel>? products;
  final List<FavoriteModel>? favorite;

  HomeState({
    this.index,
    this.categoryResult,
    this.productResult,
    this.searchResult,
    required this.categoryState,
    this.productState,
    this.search,
    this.searchState,
    this.searchSuggestions,
    this.favResult,
    this.favState,
    this.bannerImagesList,
    this.bannerImageStatus,
    this.products,
    this.favorite,
  });

  HomeState copyWith({
    QueryResult? productResult,
    QueryResult? categoryResult,
    int? indexx,
    String? categoryState,
    String? productState,
    String? search,
    QueryResult? searchRes,
    String? searchSta,
    QueryResult? searchSugges,
    QueryResult? favRes,
    String? favStat,
    List<dynamic>? bannerImagesList,
    String? bannerImageStatus,
    List<ProductModel>? products,
    List<FavoriteModel>? favorite,
  }) {
    return HomeState(
      categoryResult: categoryResult ?? this.categoryResult,
      productResult: productResult ?? this.productResult,
      categoryState: categoryState ?? this.categoryState,
      productState: productState ?? this.productState,
      search: search ?? this.search,
      searchResult: searchRes ?? searchResult,
      searchState: searchSta ?? searchState,
      searchSuggestions: searchSugges ?? searchSuggestions,
      index: indexx ?? index,
      favResult: favRes ?? favResult,
      favState: favStat ?? favState,
      bannerImagesList: bannerImagesList ?? this.bannerImagesList,
      bannerImageStatus: bannerImageStatus ?? this.bannerImageStatus,
      products: products ?? this.products,
      favorite: favorite ?? this.favorite,
    );
  }
}
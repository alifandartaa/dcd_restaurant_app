import 'dart:io';

import 'package:dcd_restaurant_app/models/search_restaurant.dart';
import 'package:flutter/cupertino.dart';

import '../api/api_service.dart';

enum ResultSearchState { loading, noData, hasData, error }

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;
  // static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  SearchProvider({required this.apiService}) {
    // _query = '';
    searchByQuery(query);
  }

  ResultSearchState? _state;
  SearchResponse? _searchResponse;
  String _message = '';
  String _query = 'tes';

  ResultSearchState? get state => _state;
  SearchResponse? get result => _searchResponse;
  String get message => _message;
  String get query => _query;

  Future<dynamic> searchByQuery(String query) async {
    try {
      _state = ResultSearchState.loading;
      _query = query;
      notifyListeners();
      // final response = await http.get(Uri.parse("${_baseUrl}search?q=$query"));
      final resultQuerySearch = await apiService.getSearchByQuery(query);
      // var result = SearchResponse.fromJson(json.decode(response.body));
      if (resultQuerySearch.restaurants.isEmpty) {
        _state = ResultSearchState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultSearchState.hasData;
        notifyListeners();
        return _searchResponse = resultQuerySearch;
      }
    } on SocketException catch (e) {
      _state = ResultSearchState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}

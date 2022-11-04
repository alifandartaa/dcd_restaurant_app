import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../api/api_service.dart';
import '../models/detail_restaurant.dart';
import 'package:http/http.dart' as http;

enum ResultDetailState { loading, noData, hasData, error }

class DetailRestaurantProvider extends ChangeNotifier {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  final ApiService apiService;
  late ResultDetailState _state;
  late DetailRestaurantResponse _detailRestaurantResponse;
  String _message = '';

  ResultDetailState get state => _state;
  DetailRestaurantResponse get resultDetail => _detailRestaurantResponse;
  String get message => _message;

  DetailRestaurantProvider({required this.apiService, required String id}) {
    _fetchRestaurantByIdData(id);
  }

  Future<dynamic> _fetchRestaurantByIdData(id) async {
    try {
      _state = ResultDetailState.loading;
      notifyListeners();
      final response = await http.get(Uri.parse("${_baseUrl}detail/$id"));
      // final detailRestaurant = await apiService.getRestaurantById(id);
      var result =
          DetailRestaurantResponse.fromJson(json.decode(response.body));
      if (result.message != "success") {
        _state = ResultDetailState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultDetailState.hasData;
        notifyListeners();
        return _detailRestaurantResponse = result;
      }
    } on SocketException catch (e) {
      _state = ResultDetailState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}

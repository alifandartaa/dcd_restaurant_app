import 'dart:io';

import 'package:dcd_restaurant_app/api/api_service.dart';
import 'package:dcd_restaurant_app/models/restaurant.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

enum ResultRestaurantState { loading, noData, hasData, error }

class RestaurantsProvider extends ChangeNotifier {
  final ApiService apiService;

  late ResultRestaurantState _state;
  late RestaurantResponse _restaurantResponse;
  String _message = '';

  ResultRestaurantState get state => _state;
  RestaurantResponse get result => _restaurantResponse;
  String get message => _message;

  RestaurantsProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultRestaurantState.loading;
      notifyListeners();
      // final response = await http.get(Uri.parse('${_baseUrl}list'));
      final result = await apiService.getRestaurants(http.Client());
      // var result = RestaurantResponse.fromJson(json.decode(response.body));
      if (result.restaurants.isEmpty) {
        _state = ResultRestaurantState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultRestaurantState.hasData;
        notifyListeners();
        return _restaurantResponse = result;
      }
    } on SocketException catch (e) {
      _state = ResultRestaurantState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}

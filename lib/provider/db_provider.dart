import 'package:dcd_restaurant_app/data/database_helper.dart';
import 'package:flutter/cupertino.dart';

import '../models/restaurant.dart';

enum DbResultState { loading, noData, hasData, error }

class DbProvider extends ChangeNotifier {
  late DatabaseHelper _databaseHelper;

  late DbResultState _state;
  DbResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _restaurants = [];
  List<Restaurant> get restaurants => _restaurants;

  DbProvider() {
    _databaseHelper = DatabaseHelper();
    _getAllRestaurants();
  }

  void _getAllRestaurants() async {
    _restaurants = await _databaseHelper.getRestaurants();
    if (_restaurants.isNotEmpty) {
      _state = DbResultState.hasData;
    } else {
      _state = DbResultState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  Future<void> addRestaurant(Restaurant restaurant) async {
    try {
      await _databaseHelper.insertRestaurant(restaurant);
      _getAllRestaurants();
    } catch (e) {
      _state = DbResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoritedRestaurant = await _databaseHelper.getRestaurantById(id);
    return favoritedRestaurant.isNotEmpty;
  }

  Future<Object> getRestaurantById(String id) async {
    return await _databaseHelper.getRestaurantById(id);
  }

  void updateRestaurant(Restaurant restaurant) async {
    await _databaseHelper.updateRestaurant(restaurant);
    _getAllRestaurants();
  }

  void deleteRestaurant(String id) async {
    try {
      await _databaseHelper.deleteRestaurant(id);
      _getAllRestaurants();
    } catch (e) {
      _state = DbResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}

import 'dart:convert';
import 'package:dcd_restaurant_app/models/search_restaurant.dart';
import 'package:http/http.dart' as http;

import '../models/restaurant.dart';

class ApiService {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev/';

  // http.Client client;
  // ApiService({required this.client});

  Future<RestaurantResponse> getRestaurants(http.Client client) async {
    final response = await client.get(Uri.parse('${baseUrl}list'));
    if (response.statusCode == 200) {
      return RestaurantResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load get restaurants');
    }
  }

  // Future<DetailRestaurantResponse> getRestaurantById(String id) async {
  //   try {
  //     final response = await http.get(Uri.parse("${_baseUrl}detail/$id"));
  //     if (response.statusCode == 200) {
  //       return DetailRestaurantResponse.fromJson(json.decode(response.body));
  //     } else {
  //       throw Exception('Failed to load get detail restaurant');
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<SearchResponse> getSearchByQuery(String query) async {
    final response = await http.get(Uri.parse("${baseUrl}search?q=$query"));
    if (response.statusCode == 200) {
      return SearchResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load get search by query');
    }
  }

  Future<String> postReview(String id, String name, String review) async {
    try {
      final response = await http.post(Uri.parse("${baseUrl}review"),
          body: {'id': id, 'name': name, 'review': review});

      if (response.statusCode == 201) {
        return "";
      } else {
        throw Exception('Failed to post review');
      }
    } catch (e) {
      rethrow;
    }
  }
}

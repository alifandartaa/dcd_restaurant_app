import 'dart:io';

import 'package:dcd_restaurant_app/api/api_service.dart';
import 'package:flutter/cupertino.dart';

enum ResultReviewState { loading, success, error }

class ReviewProvider extends ChangeNotifier {
  final ApiService apiService;
  late ResultReviewState _state;
  String _message = '';
  String _id = '';
  String _name = '';
  String _review = '';

  ResultReviewState get state => _state;
  String get message => _message;
  String get id => _id;
  String get name => _name;
  String get review => _review;

  ReviewProvider({required this.apiService}) {
    // postReviewById(id, name, review);
  }

  Future<dynamic> postReviewById(String id, String name, String review) async {
    try {
      _id = id;
      _name = name;
      _review = review;
      _state = ResultReviewState.loading;
      notifyListeners();
      apiService.postReview(id, name, review);
      _state = ResultReviewState.success;
      notifyListeners();
      return _message = 'Post Review Success';
    } on SocketException catch (e) {
      _state = ResultReviewState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}

import 'package:dcd_restaurant_app/api/api_service.dart';
import 'package:dcd_restaurant_app/models/restaurant.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'restaurant_provider_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('fetchRestaurant', () {
    test('return data restaurants from http', () async {
      final client = MockClient();

      when(client.get(Uri.parse('${ApiService.baseUrl}list'))).thenAnswer(
          (_) async => http.Response(
              '{"error":false,"message":"success","count":20,"restaurants":[]}',
              200));

      expect(
          await ApiService().getRestaurants(client), isA<RestaurantResponse>());
    });
  });
}

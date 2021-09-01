import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/models/restaurant_api_model.dart';
import 'package:restaurant_app/models/restaurant_detail_model.dart';
import 'package:restaurant_app/models/restaurant_query_model.dart';

class ApiServices {
  Future<RestaurantList> getRestaurant() async {
    final response =
        await http.get(Uri.parse('https://restaurant-api.dicoding.dev/list'));
    if (response.statusCode == 200) {
      var data = RestaurantList.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('Gagal Memuat Data');
    }
  }

  Future<RestaurantDetail> getRestaurantDetail(String id) async {
    final response = await http.get(
      Uri.parse('https://restaurant-api.dicoding.dev/detail/$id'),
    );

    var data = RestaurantDetail.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception('Gagal Memuat Data');
    }
  }

  Future<RestaurantQuery> getRestaurantQuery(String context) async {
    final response = await http.get(
      Uri.parse('https://restaurant-api.dicoding.dev/search?q=$context'),
    );

    var data = RestaurantQuery.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception('Gagal Memuat Data');
    }
  }
}

// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:la_restaurant/data/model/foods.dart';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<FoodResult> getListOfRestaurant() async {
    if (!await DataConnectionChecker().hasConnection) {
      return Future.error('No Internet Connection');
    }
    var response = await http.get(Uri.parse(_baseUrl + '/list'));
    return FoodResult.fromJson(jsonDecode(response.body));
  }

  Future<List<Restaurant>> getSearchOfRestaurant(String query) async {
    if (!await DataConnectionChecker().hasConnection) {
      return Future.error('No Internet Connection');
    }
    var response = await http.get(Uri.parse(_baseUrl + '/search?q=$query'));
    Map<String, dynamic> json = jsonDecode(response.body);
    var restaurants = List.from(json['restaurants']);
    return List.from(
        restaurants.map((restaurant) => Restaurant.fromJson(restaurant)));
  }
}

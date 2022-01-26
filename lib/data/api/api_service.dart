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
}

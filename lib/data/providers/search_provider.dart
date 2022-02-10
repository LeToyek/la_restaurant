import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:la_restaurant/data/api/api_service.dart';
import 'package:la_restaurant/data/model/restaurant.dart';
import 'package:la_restaurant/data/providers/resto_provider.dart';

class SearchProvider extends ChangeNotifier {
  ApiService apiService;

  SearchProvider({required this.apiService});

  late List<Restaurant> _restaurants;
  late ResultState _state = ResultState.NoData;
  String _message = '';

  List<Restaurant> get restaurants => _restaurants;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> searchRestaurant(String query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final searchResult = await apiService.getSearchOfRestaurant(query);
      if (searchResult.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'No Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurants = searchResult;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --->$e';
    }
  }
}

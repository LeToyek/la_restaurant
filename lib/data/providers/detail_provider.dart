import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_restaurant/data/api/api_service.dart';
import 'package:la_restaurant/data/model/restaurant_detail.dart';
import 'package:la_restaurant/data/providers/resto_provider.dart';

class DetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailProvider({required this.apiService, required this.id}) {
    _fetchDetail(id);
  }

  late RestaurantDetail _restaurantDetail;
  late ResultState _state;
  late bool _favorite;
  late String _message = '';

  RestaurantDetail get restaurantDetail => _restaurantDetail;
  ResultState get state => _state;
  String get message => _message;
  bool get favorite => _favorite;

  Future<dynamic> _fetchDetail(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final detail = await apiService.getDetailOfRestaurant(id);
      if (detail.menus.drinks.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'No Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantDetail = detail;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error ---> $e';
    }
  }
}

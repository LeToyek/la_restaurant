import 'package:flutter/cupertino.dart';
import 'package:la_restaurant/data/api/api_service.dart';
import 'package:la_restaurant/data/model/foods.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestoProvider extends ChangeNotifier {
  final ApiService apiService;

  RestoProvider({required this.apiService}) {
    _fetchAllFood();
  }

  late FoodResult _foodResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  FoodResult get result => _foodResult;
  ResultState get state => _state;

  Future<dynamic> _fetchAllFood() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final food = await apiService.getListOfRestaurant();
      if (food.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'No Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _foodResult = food;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}

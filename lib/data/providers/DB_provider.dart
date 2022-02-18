import 'package:flutter/cupertino.dart';
import 'package:la_restaurant/data/providers/resto_provider.dart';
import 'package:la_restaurant/database/database_helper.dart';
import 'package:provider/provider.dart';

import '../model/restaurant.dart';

class DBProvider extends ChangeNotifier {
  final DBHelper dbHelper;
  DBProvider({required this.dbHelper}) {
    _getAllFavorite();
  }

  ResultState _state = ResultState.NoData;
  String _message = '';
  late List<Restaurant> _favRestaurants;

  ResultState get state => _state;
  String get message => _message;
  List<Restaurant> get favRestaurants => _favRestaurants;

  void _getAllFavorite() async {
    _favRestaurants = await dbHelper.getAllFavResto();
    _state =
        _favRestaurants.isNotEmpty ? ResultState.HasData : ResultState.NoData;
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await dbHelper.insertFavRest0(restaurant);
      _getAllFavorite();
    } catch (e) {
      _message = e.toString();
      _state = ResultState.Error;
      notifyListeners();
    }
  }

  void deleteFavorite(String id) async {
    try {
      await dbHelper.deleteFavResto(id);
      _getAllFavorite();
    } catch (e) {
      _message = e.toString();
      _state = ResultState.Error;
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    var favResto = await dbHelper.getFavRestoByID(id);
    return favResto != null;
  }
}

import 'package:flutter/material.dart';
import 'package:la_restaurant/data/providers/DB_provider.dart';
import 'package:la_restaurant/data/providers/resto_provider.dart';
import 'package:la_restaurant/widgets/card_foods.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Expanded(child: Consumer<DBProvider>(
      builder: (context, value, child) {
        if (value.state == ResultState.NoData) {
          return Center(
            child: Text('No data'),
          );
        } else {
          final restaurants = value.favRestaurants;
          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              return CardFoods(food: restaurants[index]);
            },
          );
        }
      },
    )));
  }
}

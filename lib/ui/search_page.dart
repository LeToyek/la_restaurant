import 'package:flutter/material.dart';
import 'package:la_restaurant/data/api/api_service.dart';
import 'package:la_restaurant/data/model/foods.dart';
import 'package:la_restaurant/data/providers/resto_provider.dart';
import 'package:la_restaurant/data/providers/search_provider.dart';
import 'package:la_restaurant/widgets/card_foods.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ChangeNotifierProvider<SearchProvider>(
          create: (context) => SearchProvider(apiService: ApiService()),
          child: Column(
            children: [
              Consumer<SearchProvider>(builder: (context, state, _) {
                return TextField(
                  autofocus: true,
                  onSubmitted: state.searchRestaurant,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32)),
                      isDense: true),
                );
              }),
              Consumer<SearchProvider>(builder: (context, state, _) {
                if (state.state == ResultState.HasData) {
                  return ListView.builder(
                      itemCount: state.restaurants.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var restaurant = state.restaurants[index];
                        return CardFoods(food: restaurant);
                      });
                } else if (state.state == ResultState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.state == ResultState.NoData) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return Center(
                    child: Column(
                      children: [Text('Search by inputing name or menu above')],
                    ),
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}

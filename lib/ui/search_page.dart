import 'package:flutter/material.dart';
import 'package:la_restaurant/data/api/api_service.dart';
import 'package:la_restaurant/data/model/foods.dart';
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
                      label: Text('search'),
                      border: OutlineInputBorder(),
                      isDense: true),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

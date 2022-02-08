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
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(16),
          child: ChangeNotifierProvider<SearchProvider>(
            create: (context) => SearchProvider(apiService: ApiService()),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Search',
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 16,
                  ),
                  Consumer<SearchProvider>(builder: (context, state, _) {
                    return TextField(
                      autofocus: true,
                      onSubmitted: state.searchRestaurant,
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32)),
                          isDense: true),
                    );
                  }),
                  SizedBox(
                    height: 16,
                  ),
                  Consumer<SearchProvider>(builder: (context, state, _) {
                    if (state.state == ResultState.HasData) {
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
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
                    } else if (state.state == ResultState.Error) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else {
                      return Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Image.asset('images/search.png')],
                      ));
                    }
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

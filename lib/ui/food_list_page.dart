import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_restaurant/resto_provider.dart';
import 'package:la_restaurant/widgets/card_foods.dart';
import 'package:la_restaurant/widgets/platform_widget.dart';
import 'package:la_restaurant/widgets/search_widge.dart';
import 'package:provider/provider.dart';

class FoodListPage extends StatelessWidget {
  const FoodListPage({Key? key}) : super(key: key);

  Widget _buildList() {
    return Consumer<RestoProvider>(builder: (context, state, _) {
      if (state.state == ResultState.Loading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state.state == ResultState.HasData) {
        return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var food = state.result.restaurants[index];
              return CardFoods(food: food);
            });
      } else if (state.state == ResultState.NoData) {
        return Center(
          child: Text(state.message),
        );
      } else {
        return Center(
          child: Text(state.message),
        );
      }
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Icon(Icons.menu),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Find Your Best Restaurant',
                    style: Theme.of(context).textTheme.headline4),
                SearchBar(),
                _buildList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIOS(BuildContext context) {
    return CupertinoPageScaffold(
      child: _buildList(),
      navigationBar: CupertinoNavigationBar(
        trailing: Icon(Icons.search),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIOS);
  }
}

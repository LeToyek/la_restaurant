import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_restaurant/data/providers/resto_provider.dart';
import 'package:la_restaurant/style/color.dart';
import 'package:la_restaurant/widgets/card_foods.dart';
import 'package:la_restaurant/widgets/main_title.dart';
import 'package:la_restaurant/widgets/platform_widget.dart';
import 'package:la_restaurant/ui/search_page.dart';
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainTitle(),
              SizedBox(
                height: 16,
              ),
              // Text('Find Your Best Restaurant',
              //     style: Theme.of(context).textTheme.headline4),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildList(),
              ),
            ],
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

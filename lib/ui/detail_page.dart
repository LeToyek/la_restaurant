import 'package:flutter/material.dart';
import 'package:la_restaurant/data/image_url.dart';
import 'package:la_restaurant/data/model/restaurant.dart';
import 'package:la_restaurant/data/providers/detail_provider.dart';
import 'package:la_restaurant/data/providers/resto_provider.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  static const String routeName = 'detail_page';
  final Restaurant food;

  DetailPage({required this.food});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<DetailProvider>(
        builder: ((context, state, _) {
          if (state.state == ResultState.Loading) {
            return CircularProgressIndicator();
          } else if (state.state == ResultState.HasData) {
            return SafeArea(
                child: Column(
              children: [
                Container(
                  height: size.height * 0.3,
                  child: Container(
                    height: size.height * 0.3 - 16,
                    child: Image.network(ImageUrl.Large(
                        state.restaurantDetail.restaurant.pictureId)),
                  ),
                )
              ],
            ));
          } else if (state.state == ResultState.NoData) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Center(
              child: Text(state.message),
            );
          }
        }),
      ),
    );
  }
}

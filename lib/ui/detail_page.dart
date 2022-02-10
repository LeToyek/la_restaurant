import 'package:flutter/material.dart';
import 'package:la_restaurant/data/image_url.dart';
import 'package:la_restaurant/data/model/restaurant.dart';

class DetailPage extends StatelessWidget {
  static const String routeName = 'detail_page';
  final Restaurant food;

  DetailPage({required this.food});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: size.height * 0.3,
            child: Container(
              height: size.height * 0.3 - 16,
              child: Image.network(ImageUrl.Large(food.pictureId)),
            ),
          )
        ],
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:la_restaurant/data/image_url.dart';
import 'package:la_restaurant/data/model/foods.dart';

class CardFoods extends StatelessWidget {
  final Restaurant food;

  CardFoods({required this.food});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(ImageUrl.small(food.pictureId)),
      title: Text(food.name),
      subtitle: Column(
        children: [
          Row(
            children: [Icon(Icons.location_pin), Text(food.city)],
          ),
          Row(
            children: [Icon(Icons.star), Text(food.rating.toString())],
          )
        ],
      ),
    );
  }
}

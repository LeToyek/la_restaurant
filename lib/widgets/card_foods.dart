import 'package:flutter/material.dart';
import 'package:la_restaurant/data/image_url.dart';
import 'package:la_restaurant/data/model/restaurant.dart';
import 'package:la_restaurant/ui/detail_page.dart';

class CardFoods extends StatelessWidget {
  final Restaurant food;
  CardFoods({required this.food});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, DetailPage.routeName,
          arguments: food.id),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.only(bottom: 16),
        elevation: 0.5,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(ImageUrl.small(food.pictureId))),
            ),
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text(food.name),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_pin, size: 16, color: Colors.grey),
                        Text(food.city)
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.grey,
                        ),
                        Text(food.rating.toString())
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

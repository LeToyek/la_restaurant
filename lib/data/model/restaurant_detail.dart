// To parse this JSON data, do
//
//     final foodDetail = foodDetailFromJson(jsonString);

import 'dart:convert';

import 'package:la_restaurant/data/model/restaurant.dart';

import 'customer_review.dart';
import 'menu.dart';

RestaurantDetail foodDetailFromJson(String str) =>
    RestaurantDetail.fromJson(json.decode(str));

class RestaurantDetail {
  RestaurantDetail({
    required this.restaurant,
    required this.menus,
    required this.customerReviews,
    required this.categories,
  });

  Menus menus;
  List<Category> categories;
  Restaurant restaurant;
  List<CustomerReview> customerReviews;

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
        restaurant: Restaurant.fromJson(json["restaurant"]),
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        menus: Menus.fromJson(json["menus"]),
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );
}

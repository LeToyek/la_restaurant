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
  RestaurantDetail(
      {required this.menus,
      required this.customerReviews,
      required this.categories,
      required this.pictureId,
      required this.name,
      required this.address,
      required this.description});

  Menus menus;
  List<Category> categories;
  String pictureId, name, address, description;
  List<CustomerReview> customerReviews;

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
        name: json['name'],
        description: json['description'],
        address: json['address'],
        pictureId: json['pictureId'],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        menus: Menus.fromJson(json["menus"]),
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );
}

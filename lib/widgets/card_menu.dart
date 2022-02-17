import 'package:flutter/material.dart';
import 'package:la_restaurant/data/model/menu.dart';

class CardMenu extends StatelessWidget {
  final String name;

  CardMenu({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(name),
    );
  }
}

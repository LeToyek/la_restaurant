import 'package:flutter/material.dart';
import 'package:la_restaurant/data/model/foods.dart';

class SearchBar extends StatefulWidget {
  final Restaurant food;

  SearchBar({required this.food});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  var data =

  void _handleSearch(query){
    var searchResult = 
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          label: Text('search'), border: OutlineInputBorder(), isDense: true),
    );
  }
}

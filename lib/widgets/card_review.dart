import 'package:flutter/material.dart';

class CardReview extends StatelessWidget {
  final String name, review, date;

  CardReview({required this.name, required this.review, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [Text(name), Text(review), Text(date)]),
    );
  }
}

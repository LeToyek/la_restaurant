import 'package:flutter/material.dart';
import 'package:la_restaurant/data/model/restaurant.dart';
import 'package:la_restaurant/ui/detail_page.dart';
import 'package:la_restaurant/ui/home_page.dart';
import 'package:la_restaurant/ui/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: DetailPage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        SearchPage.routeName: (context) => SearchPage(),
        DetailPage.routeName: (context) => DetailPage(
            food: ModalRoute.of(context)?.settings.arguments as Restaurant)
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

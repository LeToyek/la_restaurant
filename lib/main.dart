import 'package:flutter/material.dart';
import 'package:la_restaurant/data/api/api_service.dart';
import 'package:la_restaurant/data/model/restaurant.dart';
import 'package:la_restaurant/data/model/restaurant_detail.dart';
import 'package:la_restaurant/data/providers/DB_provider.dart';
import 'package:la_restaurant/data/providers/resto_provider.dart';
import 'package:la_restaurant/database/database_helper.dart';
import 'package:la_restaurant/ui/detail_page.dart';
import 'package:la_restaurant/ui/home_page.dart';
import 'package:la_restaurant/ui/search_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DBProvider>(
            create: ((context) => DBProvider(dbHelper: DBHelper()))),
        ChangeNotifierProvider<RestoProvider>(
            create: ((context) => RestoProvider(apiService: ApiService())))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => HomePage(),
          SearchPage.routeName: (context) => SearchPage(),
          DetailPage.routeName: (context) => DetailPage()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

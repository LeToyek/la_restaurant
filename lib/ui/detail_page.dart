import 'package:flutter/material.dart';
import 'package:la_restaurant/data/api/api_service.dart';
import 'package:la_restaurant/data/image_url.dart';
import 'package:la_restaurant/data/model/restaurant.dart';
import 'package:la_restaurant/data/providers/detail_provider.dart';
import 'package:la_restaurant/data/providers/resto_provider.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  static const String routeName = '/detail_page';

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ChangeNotifierProvider.value(
        value: DetailProvider(
            apiService: ApiService(),
            id: ModalRoute.of(context)?.settings.arguments as String),
        child: Consumer<DetailProvider>(
          builder: ((context, state, _) {
            if (state.state == ResultState.Loading) {
              return CircularProgressIndicator();
            } else if (state.state == ResultState.HasData) {
              return SafeArea(
                  child: Column(
                children: [
                  Container(
                    height: size.height * 0.3,
                    child: Container(
                      height: size.height * 0.3 - 16,
                      child: Image.network(
                          ImageUrl.Large(state.restaurantDetail.pictureId)),
                    ),
                  )
                ],
              ));
            } else if (state.state == ResultState.NoData) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Center(
                child: Text(state.message),
              );
            }
          }),
        ),
      ),
    );
  }
}

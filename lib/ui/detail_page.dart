import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:la_restaurant/data/api/api_service.dart';
import 'package:la_restaurant/data/image_url.dart';
import 'package:la_restaurant/data/model/menu.dart';
import 'package:la_restaurant/data/model/restaurant.dart';
import 'package:la_restaurant/data/model/restaurant_detail.dart';
import 'package:la_restaurant/data/providers/DB_provider.dart';
import 'package:la_restaurant/data/providers/detail_provider.dart';
import 'package:la_restaurant/data/providers/resto_provider.dart';
import 'package:la_restaurant/style/color.dart';
import 'package:la_restaurant/widgets/card_menu.dart';
import 'package:la_restaurant/widgets/card_review.dart';
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
    var smallHeadline = Theme.of(context).textTheme.headline6;
    var favRestoId = ModalRoute.of(context)?.settings.arguments as String;
    var gap = SizedBox(
      height: 8,
    );
    return Scaffold(
      body: ChangeNotifierProvider.value(
        value: DetailProvider(apiService: ApiService(), id: favRestoId),
        child: Consumer<DetailProvider>(
          builder: ((context, state, _) {
            if (state.state == ResultState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.HasData) {
              var stater = state.restaurantDetail;
              return SafeArea(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(16)),
                                child: Image.network(
                                  ImageUrl.Large(state
                                      .restaurantDetail.restaurant.pictureId),
                                  width: double.infinity,
                                ),
                              ),
                              SizedBox(
                                height: 24,
                              )
                            ],
                          ),
                          Positioned(
                            bottom: 0,
                            right: 24,
                            child: Consumer<DBProvider>(
                              builder: (context, value, child) {
                                return FutureBuilder(
                                    future: value.isFavorite(favRestoId),
                                    builder: ((context, snapshot) {
                                      if (snapshot.hasData) {
                                        final _isFavorite = snapshot.hasData;
                                        return Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white),
                                            child: IconButton(
                                                onPressed: () {
                                                  _isFavorite
                                                      ? value.deleteFavorite(
                                                          favRestoId)
                                                      : value.addFavorite(
                                                          stater.restaurant);
                                                },
                                                icon: _isFavorite
                                                    ? Icon(
                                                        Icons.favorite,
                                                        color: kPrimaryColor,
                                                        size: 32,
                                                      )
                                                    : Icon(
                                                        Icons
                                                            .favorite_border_outlined,
                                                        color: kPrimaryColor,
                                                        size: 32,
                                                      )));
                                      } else {
                                        return Container();
                                      }
                                    }));
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.restaurantDetail.restaurant.name,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          gap,
                          Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                size: 16,
                              ),
                              Text(state.restaurantDetail.restaurant.city),
                            ],
                          ),
                          RatingBarIndicator(
                            itemBuilder: ((context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                )),
                            itemCount: 5,
                            rating: stater.restaurant.rating,
                            direction: Axis.horizontal,
                            itemSize: 16,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Deskripsi',
                            style: smallHeadline,
                          ),
                          gap,
                          Text(state.restaurantDetail.restaurant.description),
                          gap,
                          Text(
                            'Foods',
                            style: smallHeadline,
                          ),
                          ListView(
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: stater.menus.foods
                                  .map((e) => CardMenu(name: e.name))
                                  .toList()),
                          Text(
                            'Drinks',
                            style: smallHeadline,
                          ),
                          ListView(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: stater.menus.drinks
                                .map((e) => CardMenu(name: e.name))
                                .toList(),
                          ),
                          ListView(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: stater.customerReviews
                                .map((e) => CardReview(
                                    name: e.name,
                                    review: e.review,
                                    date: e.date))
                                .toList(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
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

import 'package:flutter/material.dart';
import 'package:la_restaurant/data/providers/detail_provider.dart';
import 'package:la_restaurant/data/providers/resto_provider.dart';
import 'package:la_restaurant/style/color.dart';
import 'package:la_restaurant/ui/search_page.dart';
import 'package:provider/provider.dart';

class MainTitle extends StatelessWidget {
  const MainTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.3,
      child: Stack(
        children: [
          Container(
              height: size.height * 0.3 - 16,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(36)),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(
                  height: 48,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hi Toyek',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Icon(Icons.person, color: Colors.white)
                  ],
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, SearchPage.routeName),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 56,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 40,
                            color: kPrimaryColor.withOpacity(0.2))
                      ]),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Search',
                        style: TextStyle(color: kPrimaryColor.withOpacity(0.5)),
                      )),
                      Icon(Icons.search, color: kPrimaryColor.withOpacity(0.5))
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

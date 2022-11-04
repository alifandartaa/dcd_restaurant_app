import 'package:dcd_restaurant_app/provider/db_provider.dart';
import 'package:dcd_restaurant_app/widgets/favorite_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../shared/styles.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = '/favorite_page';

  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              'Favorite Res',
              style: myTextTheme.bodyText1?.copyWith(
                fontSize: 30,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 18,
            ),
            Consumer<DbProvider>(builder: (_, provider, child) {
              final restaurants = provider.restaurants;

              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      var restaurant = restaurants[index];
                      return FavoriteItem(restaurant: restaurant);
                    }),
              );
            }),
          ],
        ),
      ),
    );
  }
}

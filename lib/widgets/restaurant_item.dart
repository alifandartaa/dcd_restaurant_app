import 'package:cached_network_image/cached_network_image.dart';
import 'package:dcd_restaurant_app/shared/styles.dart';
import 'package:flutter/material.dart';

import '../models/restaurant.dart';
import '../pages/detail_page.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantItem({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName,
            arguments: restaurant.id);
      },
      child: Container(
        width: width,
        height: height * 0.15,
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.02, vertical: height * 0.01),
        margin: EdgeInsets.only(bottom: height * 0.04),
        decoration: BoxDecoration(
          color: const Color(0xffF6F7FB),
          // color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(children: [
          Flexible(
            child: Hero(
              tag: restaurant.pictureId,
              child: CircleAvatar(
                minRadius: width * 0.05,
                maxRadius: width * 0.07,
                backgroundImage: CachedNetworkImageProvider(
                    'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}'),
              ),
            ),
          ),
          SizedBox(
            width: width * 0.02,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.bodyText1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.fmd_good_sharp,
                          color: Colors.red, size: 16),
                      Text(
                        restaurant.city,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: greyColor,
                            ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/icon_star.png',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        restaurant.rating.toString(),
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              fontSize: 14,
                              fontWeight: medium,
                              color: greyColor,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

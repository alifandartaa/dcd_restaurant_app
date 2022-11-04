import 'package:cached_network_image/cached_network_image.dart';
import 'package:dcd_restaurant_app/api/api_service.dart';
import 'package:dcd_restaurant_app/models/detail_restaurant.dart';
import 'package:dcd_restaurant_app/provider/db_provider.dart';
import 'package:dcd_restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:dcd_restaurant_app/shared/styles.dart';
import 'package:dcd_restaurant_app/widgets/foods_drink_item.dart';
import 'package:dcd_restaurant_app/widgets/review_dialog.dart';
import 'package:dcd_restaurant_app/widgets/review_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/restaurant.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail_page';

  final String restaurantId;

  const DetailPage({Key? key, required this.restaurantId}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    Widget cover(DetailRestaurant? restaurant) {
      return Hero(
        tag: restaurant!.pictureId,
        child: Container(
          width: double.infinity,
          height: height * 0.55,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(
                  'https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}'),
            ),
          ),
          child: Container(
            margin: EdgeInsets.only(top: height * 0.2),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: whiteColor,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.fmd_good_sharp,
                              color: Colors.red, size: 24),
                          Text(
                            restaurant.city,
                            style:
                                Theme.of(context).textTheme.subtitle2?.copyWith(
                                      color: whiteColor,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/icon_star.png',
                          ),
                        ),
                      ),
                    ),
                    Text(
                      restaurant.rating.toString(),
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: whiteColor,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget customShadow() {
      return Container(
        width: double.infinity,
        height: height * 0.25,
        margin: EdgeInsets.only(
          top: height * 0.3,
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              whiteColor.withOpacity(0),
              greyColor.withOpacity(0.3)
            ])),
      );
    }

    Widget content(DetailRestaurant? restaurant) {
      return Column(
        children: [
          //! NOTE : WHITE BOX CONTENT
          Container(
            height: height * 0.9,
            margin: EdgeInsets.only(
              top: height * 0.45,
              right: 24,
              left: 24,
            ),
            padding:
                EdgeInsets.symmetric(horizontal: 20, vertical: height * 0.04),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18), color: whiteColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  restaurant!.description,
                  style: Theme.of(context).textTheme.bodyText2,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  'Foods',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                SizedBox(
                  height: height * 0.09,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: restaurant.menus.foods.length,
                      itemBuilder: (context, index) {
                        return FoodsDrinkItem(
                            category: restaurant.menus.foods[index]);
                      }),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  'Drinks',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                SizedBox(
                  height: height * 0.09,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: restaurant.menus.drinks.length,
                      itemBuilder: (context, index) {
                        return FoodsDrinkItem(
                            category: restaurant.menus.drinks[index]);
                      }),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  'Customer Review',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                //! NOTE : GET CUSTOMER REVIEW ITEM
                SizedBox(
                  height: height * 0.14,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: restaurant.customerReviews.length,
                      itemBuilder: (context, index) {
                        return ReviewItem(
                            customerReview: restaurant.customerReviews[index]);
                      }),
                ),
              ],
            ),
          ),
          //! NOTE : ADD FAVORITE
          Consumer<DbProvider>(
            builder: (context, provider, child) {
              return FutureBuilder<bool>(
                future: provider.isFavorite(restaurant.id),
                builder: (context, snapshot) {
                  var isFavorite = snapshot.data ?? false;
                  return Container(
                    width: double.infinity,
                    height: height * 0.07,
                    margin: EdgeInsets.only(
                        right: 24,
                        left: 24,
                        top: height * 0.02,
                        bottom: height * 0.02),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: () async {
                        final favRestaurant = Restaurant(
                          id: restaurant.id,
                          name: restaurant.name,
                          city: restaurant.city,
                          description: restaurant.description,
                          pictureId: restaurant.pictureId,
                          rating: restaurant.rating,
                        );
                        if (isFavorite) {
                          Provider.of<DbProvider>(context, listen: false)
                              .deleteRestaurant(favRestaurant.id);
                          setState(() {
                            isFavorite = false;
                          });
                        } else {
                          Provider.of<DbProvider>(context, listen: false)
                              .addRestaurant(favRestaurant);
                          setState(() {
                            isFavorite = true;
                          });
                        }
                      },
                      child: Text(
                        isFavorite ? 'Remove Favorite' : 'Add Favorite',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: whiteColor,
                            ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          //! NOTE : SEND REVIEW
          Container(
            width: double.infinity,
            height: height * 0.07,
            margin: EdgeInsets.only(
                right: 24, left: 24, top: height * 0.02, bottom: height * 0.02),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) => ReviewDialog(
                  id: widget.restaurantId,
                ),
              ),
              child: Text(
                'Send Review',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: whiteColor,
                    ),
              ),
            ),
          ),
        ],
      );
    }

    Widget customCardDetail(DetailRestaurant? restaurant) {
      return Stack(
        children: [
          cover(restaurant),
          customShadow(),
          content(restaurant),
        ],
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: ChangeNotifierProvider(
            create: (_) => DetailRestaurantProvider(
                apiService: ApiService(), id: widget.restaurantId),
            child: Consumer<DetailRestaurantProvider>(
                builder: (context, state, _) {
              if (state.state == ResultDetailState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (state.state == ResultDetailState.hasData) {
                  return customCardDetail(state.resultDetail.restaurant);
                } else if (state.state == ResultDetailState.noData) {
                  return Center(
                    child: Material(
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return const Center(
                      child: Material(child: Text('No Internet Connection')));
                }
              }
            }),
          ),
        ),
      ),
    );
  }
}

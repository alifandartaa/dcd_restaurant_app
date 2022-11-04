import 'package:dcd_restaurant_app/api/api_service.dart';
import 'package:dcd_restaurant_app/models/restaurant.dart';
import 'package:dcd_restaurant_app/pages/detail_page.dart';
import 'package:dcd_restaurant_app/pages/favorite_page.dart';
import 'package:dcd_restaurant_app/pages/search_page.dart';
import 'package:dcd_restaurant_app/pages/settings_page.dart';
import 'package:dcd_restaurant_app/provider/restaurants_provider.dart';
import 'package:dcd_restaurant_app/shared/styles.dart';
import 'package:dcd_restaurant_app/widgets/restaurant_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/notification_helper.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController editingController = TextEditingController();
  List<Restaurant> currentList = [];
  List<Restaurant> originList = [];
  List<Restaurant> restaurantSearchList = [];

  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(DetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantsProvider(apiService: ApiService()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: whiteColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kBackgroundColor,
          centerTitle: false,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.settings),
                tooltip: 'Settings',
                onPressed: () {
                  Navigator.pushNamed(context, SettingsPage.routeName);
                },
              );
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                Navigator.pushNamed(context, FavoritePage.routeName);
              },
              tooltip: 'Favorite',
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.pushNamed(context, SearchPage.routeName);
              },
              tooltip: 'Search',
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                'Popular Restaurant',
                style: myTextTheme.bodyText1?.copyWith(
                  fontSize: 30,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 18,
              ),
              Consumer<RestaurantsProvider>(builder: (context, state, _) {
                if (state.state == ResultRestaurantState.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (state.state == ResultRestaurantState.hasData) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: state.result.restaurants.length,
                          itemBuilder: (context, index) {
                            var restaurant = state.result.restaurants[index];
                            return RestaurantItem(restaurant: restaurant);
                          }),
                    );
                  } else if (state.state == ResultRestaurantState.noData) {
                    return Center(
                      child: Material(
                        child: Text(state.message),
                      ),
                    );
                  } else {
                    return const Material(
                        child: Center(child: Text('No Internet Connection')));
                  }
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

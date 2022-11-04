import 'package:dcd_restaurant_app/shared/styles.dart';
import 'package:flutter/material.dart';

import '../models/detail_restaurant.dart';

class FoodsDrinkItem extends StatelessWidget {
  final Category category;

  const FoodsDrinkItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Container(
      width: width * 0.23,
      height: height * 0.23,
      margin: const EdgeInsets.only(
        right: 16,
      ),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.95),
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: const AssetImage(
            'assets/images/food_and_drink_icon.png',
          ),
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.9), BlendMode.modulate),
        ),
      ),
      child: Center(
        child: Text(
          category.name,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(inherit: true, shadows: [
            const Shadow(
                // bottomLeft
                offset: Offset(-1.5, -1.5),
                color: Colors.white),
            const Shadow(
                // bottomRight
                offset: Offset(1.5, -1.5),
                color: Colors.white),
            const Shadow(
                // topRight
                offset: Offset(1.5, 1.5),
                color: Colors.white),
            const Shadow(
                // topLeft
                offset: Offset(-1.5, 1.5),
                color: Colors.white),
          ]),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

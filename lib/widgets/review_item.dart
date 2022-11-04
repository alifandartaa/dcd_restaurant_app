import 'package:dcd_restaurant_app/models/detail_restaurant.dart';
import 'package:flutter/material.dart';

import '../shared/styles.dart';

class ReviewItem extends StatelessWidget {
  final CustomerReview customerReview;
  const ReviewItem({Key? key, required this.customerReview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Container(
      width: width * 0.4,
      margin: const EdgeInsets.only(
        right: 16,
      ),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.95),
        borderRadius: const BorderRadius.all(Radius.circular(18)),
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        children: [
          Text(
            customerReview.name,
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  color: whiteColor,
                ),
          ),
          Text(
            customerReview.review,
            maxLines: 3,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: whiteColor,
                  fontSize: 10,
                ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

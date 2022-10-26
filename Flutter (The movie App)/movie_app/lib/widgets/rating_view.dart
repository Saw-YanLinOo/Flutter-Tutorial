import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../resources/dimens.dart';

class RatingView extends StatelessWidget {
  const RatingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: 5.0,
      itemBuilder: (BuildContext context, int index) {
        return Icon(Icons.star, color: Colors.amber);
      },
      itemSize: MARGIN_MEDIUM_2,
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}

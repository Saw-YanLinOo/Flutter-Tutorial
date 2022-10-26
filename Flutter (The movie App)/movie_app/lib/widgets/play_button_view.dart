import 'package:flutter/material.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';

class PlalyButtonView extends StatelessWidget {
  const PlalyButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.play_circle,
      size: PLAY_BANNER_SIZE,
      color: PLAY_BUTTON_COLOR,
    );
  }
}

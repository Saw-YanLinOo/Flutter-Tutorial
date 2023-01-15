import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:wechat_redesign/resources/dimens.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black38,
      child: Center(
        child: Container(
          width: MARGIN_LARGE_3,
          height: MARGIN_LARGE_3,
          child: LoadingIndicator(
            indicatorType: Indicator.audioEqualizer,
          ),
        ),
      ),
    );
  }
}

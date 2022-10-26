import 'package:flutter/material.dart';
import 'package:movie_app/widgets/see_more_text.dart';
import 'package:movie_app/widgets/title_text.dart';

class TitleTextWithSeeMoreView extends StatelessWidget {
  final String titleText;
  final String seeMoreText;
  final bool seeMoreButtonVisibility;

  const TitleTextWithSeeMoreView({
    Key? key,
    required this.titleText,
    required this.seeMoreText,
    this.seeMoreButtonVisibility = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TitleText(text: titleText),
        Spacer(),
        Visibility(
          visible: seeMoreButtonVisibility,
          child: SeeMoreText(text: seeMoreText),
        ),
      ],
    );
  }
}

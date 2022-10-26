import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/base_actor_vo.dart';

import '../resources/dimens.dart';
import '../viewitems/actor_view.dart';
import 'title_text_with_see_more_view.dart';

class ActorAndCreatorSectionView extends StatelessWidget {
  final String titleText;
  final String seeMoreText;
  final bool seeMoreButtonVisibility;

  final List<BaseActorVO>? mActorList;

  const ActorAndCreatorSectionView({
    Key? key,
    required this.titleText,
    required this.seeMoreText,
    this.seeMoreButtonVisibility = true,
    this.mActorList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: TitleTextWithSeeMoreView(
            titleText: titleText,
            seeMoreText: seeMoreText,
            seeMoreButtonVisibility: seeMoreButtonVisibility,
          ),
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Container(
          height: BEST_ACTORS_HEIGHT,
          child: mActorList != null
              ? ListView(
                  scrollDirection: Axis.horizontal,
                  //padding: const EdgeInsets.only(left: MARGIN_MEDIUM),
                  children: mActorList!
                      .map((actor) => ActorView(actor: actor))
                      .toList(),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        )
      ],
    );
  }
}

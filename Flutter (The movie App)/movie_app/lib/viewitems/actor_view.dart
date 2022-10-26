import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/base_actor_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/resources/colors.dart';

import '../resources/dimens.dart';

class ActorView extends StatelessWidget {
  const ActorView({Key? key, this.actor}) : super(key: key);

  final BaseActorVO? actor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MOVIE_LIST_ITEM_WIDTH,
        margin: const EdgeInsets.only(left: MARGIN_MEDIUM),
        child: Stack(children: [
          Positioned.fill(
            child: ActorImageView(actorImageUrl: actor?.profilePath ?? ""),
          ),
          Padding(
            padding: const EdgeInsets.all(MARGIN_MEDIUM),
            child: Container(
              child: Align(
                alignment: Alignment.topRight,
                child: FavoriteButtonView(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ActorNameAndLikeView(
              name: actor?.name ?? "",
              likeCount: 0.0,
//              likeCount: actor?.popularity ?? 0.0,
            ),
          ),
        ]),
      ),
    );
  }
}

class FavoriteButtonView extends StatelessWidget {
  const FavoriteButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.favorite_border,
      color: Colors.white,
    );
  }
}

class ActorImageView extends StatelessWidget {
  const ActorImageView({
    Key? key,
    required this.actorImageUrl,
  }) : super(key: key);

  final String actorImageUrl;
  @override
  Widget build(BuildContext context) {
    return Image.network(
      '$IMAGE_BASE_URL$actorImageUrl',
      fit: BoxFit.cover,
    );
  }
}

class ActorNameAndLikeView extends StatelessWidget {
  const ActorNameAndLikeView({
    Key? key,
    required this.name,
    required this.likeCount,
  }) : super(key: key);

  final String name;
  final double likeCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM_2, vertical: MARGIN_MEDIUM_2),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_REGULAR,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: MARGIN_MEDIUM,
            ),
            Row(
              children: [
                Icon(
                  Icons.thumb_up,
                  size: MARGIN_CARD_MEDIUM_2,
                  color: Colors.amber,
                ),
                SizedBox(
                  width: MARGIN_MEDIUM,
                ),
                Text(
                  'you like $likeCount MOVIES ',
                  style: TextStyle(
                    color: HOME_SCREEN_LIST_TITLE_COLOR,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ]),
    );
  }
}

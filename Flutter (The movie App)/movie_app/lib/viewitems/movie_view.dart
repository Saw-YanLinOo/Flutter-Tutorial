import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/widgets/rating_view.dart';

class MovieView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final MovieVO mMovie;

  const MovieView(this.onTapMovie, {Key? key, required this.mMovie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: MARGIN_MEDIUM),
      width: MOVIE_LIST_ITEM_WIDTH,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              onTapMovie(mMovie.id);
            },
            child: Stack(
              children: [
                Image.network(
                  '$IMAGE_BASE_URL${mMovie.posterPath}',
                  fit: BoxFit.cover,
                  height: 200,
                ),
                // CircleAvatar(
                //   backgroundColor: PLAY_BUTTON_COLOR,
                //   child: Center(child: Text('${mMovie.index}')),
                // ),
              ],
            ),
          ),
          const SizedBox(
            height: MARGIN_MEDIUM,
          ),
          GestureDetector(
            onTap: () {
              onTapMovie(mMovie.id);
            },
            child: AutoSizeText(
              mMovie.title ?? '',
              maxLines: 2,
              style: const TextStyle(
                color: Colors.white,
                fontSize: TEXT_REGULAG_2X,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Row(
            children: const [
              Text(
                '8.9',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_REGULAR,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: MARGIN_MEDIUM,
              ),
              RatingView(),
            ],
          ),
        ],
      ),
    );
  }
}

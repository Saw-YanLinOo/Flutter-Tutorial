import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/widgets/play_button_view.dart';
import 'package:movie_app/widgets/title_text.dart';

class ShowCaseView extends StatelessWidget {
  const ShowCaseView({Key? key, this.movie}) : super(key: key);

  final MovieVO? movie;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: MARGIN_MEDIUM_2),
      width: 300,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              '$IMAGE_BASE_URL${movie?.posterPath}',
              fit: BoxFit.cover,
            ),
          ),
          const Align(
            alignment: Alignment.center,
            child: PlalyButtonView(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie?.title ?? '',
                      style: TextStyle(
                        fontSize: TEXT_REGULAG_3X,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: MARGIN_MEDIUM,
                    ),
                    TitleText(
                        text: movie?.releaseDate?.toIso8601String() ?? ""),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/resources/dimens.dart';

import '../widgets/gradient_view.dart';
import '../widgets/play_button_view.dart';

class BannerView extends StatelessWidget {
  const BannerView({Key? key, required this.mMovie, required this.onTapBanner})
      : super(key: key);

  final MovieVO mMovie;
  final Function onTapBanner;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapBanner();
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: BannerImageView(mImageUrl: mMovie.posterPath ?? ""),
          ),
          Positioned.fill(
            child: GradientView(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(MARGIN_MEDIUM_2),
              child: BannerTitleView(
                mMovieName: mMovie.title ?? '',
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: PlalyButtonView(),
          ),
        ],
      ),
    );
  }
}

class BannerTitleView extends StatelessWidget {
  const BannerTitleView({
    Key? key,
    required this.mMovieName,
  }) : super(key: key);

  final String mMovieName;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          mMovieName,
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_HEADING_1X,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          'Offical Review',
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_HEADING_1X,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class BannerImageView extends StatelessWidget {
  const BannerImageView({
    Key? key,
    required this.mImageUrl,
  }) : super(key: key);

  final String mImageUrl;
  @override
  Widget build(BuildContext context) {
    return Image.network(
      '$IMAGE_BASE_URL$mImageUrl',
      fit: BoxFit.cover,
    );
  }
}

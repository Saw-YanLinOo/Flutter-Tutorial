import 'package:flutter/material.dart';
import 'package:movie_app/bloc/movie_detail_bloc.dart';
import 'package:movie_app/data/vos/credit_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/resources/string.dart';
import 'package:movie_app/widgets/actor_and_creater_section_view.dart';
import 'package:movie_app/widgets/gradient_view.dart';
import 'package:movie_app/widgets/rating_view.dart';
import 'package:movie_app/widgets/title_text.dart';
import 'package:provider/provider.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({Key? key, required this.movieId}) : super(key: key);

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieDetailBloc(movieId),
      child: Scaffold(
        body: Selector<MovieDetailBloc, MovieVO?>(
          selector: (context, bloc) => bloc.mMovie,
          builder: (context, mMovie, child) {
            return Container(
              color: HOME_SCREEN_BACKGROUND_COLOR,
              child: mMovie == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomScrollView(
                      slivers: [
                        MovieDetailsSilverAppBarView(
                          () => Navigator.pop(context),
                          movie: mMovie,
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate([
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: MARGIN_MEDIUM_2,
                              ),
                              child: TrailerSectionView(
                                mMovie,
                              ),
                            ),
                            const SizedBox(
                              height: MARGIN_LARGE,
                            ),
                            Selector<MovieDetailBloc, List<CreditVO>?>(
                              selector: (context, bloc) => bloc.mActorsList,
                              builder: (context, mActorsList, child) {
                                return ActorAndCreatorSectionView(
                                  titleText: MOVIE_DETAILS_SCREEN_ACTORS_TITLE,
                                  seeMoreText: '',
                                  seeMoreButtonVisibility: false,
                                  mActorList: mActorsList,
                                );
                              },
                            ),
                            const SizedBox(
                              height: MARGIN_LARGE,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: MARGIN_MEDIUM_2,
                              ),
                              child: AboutFlimSectionView(mMovie),
                            ),
                            const SizedBox(
                              height: MARGIN_LARGE,
                            ),
                            Selector<MovieDetailBloc, List<CreditVO>?>(
                              selector: (context, bloc) => bloc.mCreatorsList,
                              builder: (context, mCreatorsList, child) {
                                return mCreatorsList != null &&
                                        mCreatorsList.isNotEmpty
                                    ? ActorAndCreatorSectionView(
                                        titleText:
                                            MOVIE_DETAILS_SCREEN_CREATORS_TITLE,
                                        seeMoreText:
                                            MOVIE_DETAILS_SCREEN_CREATORS_SEE_MORE,
                                        mActorList: mCreatorsList,
                                      )
                                    : const SizedBox();
                              },
                            )
                          ]),
                        ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}

class AboutFlimSectionView extends StatelessWidget {
  const AboutFlimSectionView(
    this.mMovie, {
    Key? key,
  }) : super(key: key);

  final MovieVO? mMovie;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(text: 'ABOUT FLIM'),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFlimInfoView(
          "Origin Title",
          mMovie?.originalTitle ?? '',
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFlimInfoView(
          "Type:",
          mMovie?.genres?.map((genre) => genre.name).join(',') ?? '',
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFlimInfoView(
          "Production:",
          mMovie?.productionCountry?.map((genre) => genre.name).join(',') ?? '',
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFlimInfoView(
          "Premiere:",
          mMovie?.releaseDate?.toIso8601String() ?? '',
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFlimInfoView(
          "Desription:",
          mMovie?.overview ?? '',
        ),
      ],
    );
  }
}

class AboutFlimInfoView extends StatelessWidget {
  final String label;
  final String description;

  const AboutFlimInfoView(
    this.label,
    this.description, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: Text(
            label,
            style: const TextStyle(
              color: MOVIE_DETAIL_INFO_TEXT_COLOR,
              fontSize: MARGIN_MEDIUM_2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(
          width: MARGIN_CARD_MEDIUM_2,
        ),
        Expanded(
          child: Text(
            description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: MARGIN_MEDIUM_2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class TrailerSectionView extends StatelessWidget {
  final MovieVO? mMovie;

  const TrailerSectionView(
    this.mMovie, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieTimeAndGeneralView(
          generalList:
              mMovie?.genres?.map((genre) => genre.name ?? '').toList(),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_3,
        ),
        StoryLineView(mMovie?.overview ?? ''),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Row(
          children: const [
            MovieDetailsScreenButtonView(
              'PLAY TRAILER',
              PLAY_BUTTON_COLOR,
              Icon(
                Icons.play_circle_filled,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              width: MARGIN_CARD_MEDIUM_2,
            ),
            MovieDetailsScreenButtonView(
              'RATE MOVIE',
              HOME_SCREEN_BACKGROUND_COLOR,
              Icon(
                Icons.star,
                color: PLAY_BUTTON_COLOR,
              ),
              isGhostButton: true,
            ),
          ],
        ),
      ],
    );
  }
}

class MovieDetailsScreenButtonView extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Icon buttonIcon;
  final bool isGhostButton;

  const MovieDetailsScreenButtonView(
    this.title,
    this.backgroundColor,
    this.buttonIcon, {
    Key? key,
    this.isGhostButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: MARGIN_CARD_MEDIUM_2,
      ),
      height: MARGIN_XXL_LARGE,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          MARGIN_LARGE,
        ),
        border: isGhostButton
            ? Border.all(
                color: Colors.white,
                width: 2,
              )
            : null,
      ),
      child: Row(
        children: [
          buttonIcon,
          const SizedBox(
            width: MARGIN_MEDIUM,
          ),
          const Text(
            'PLAY TRAILER',
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAG_2X,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class StoryLineView extends StatelessWidget {
  const StoryLineView(
    this.description, {
    Key? key,
  }) : super(key: key);

  final String description;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(
          text: MOVIE_DETAILS_SCREEN_STORE_LINE_TITLE,
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Text(
          description,
          style: const TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAG_2X,
          ),
        ),
      ],
    );
  }
}

class MovieTimeAndGeneralView extends StatelessWidget {
  const MovieTimeAndGeneralView({
    Key? key,
    this.generalList,
  }) : super(key: key);

  final List<String>? generalList;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.horizontal,
      children: _createMoveTimeAndGenreWidget(),
    );
  }

  List<Widget> _createMoveTimeAndGenreWidget() {
    List<Widget> widgets = [
      const Icon(
        Icons.access_time,
        color: PLAY_BUTTON_COLOR,
      ),
      const SizedBox(width: MRAGIN_SMALL),
      const Text(
        '2h 30min',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(width: MARGIN_MEDIUM),
    ];

    widgets.addAll(generalList?.map((e) => GeneralChipView(e)).toList() ?? []);
    widgets.add(const Icon(
      Icons.favorite_border,
      color: Colors.white,
    ));

    return widgets;
  }
}

class GeneralChipView extends StatelessWidget {
  final String generalText;

  const GeneralChipView(
    this.generalText, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Chip(
          backgroundColor: MOVIE_DETAILS_SCREEN_CHIP_BACKGROUND_COLOR,
          label: Text(
            generalText,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          width: MARGIN_MEDIUM,
        ),
      ],
    );
  }
}

class MovieDetailsSilverAppBarView extends StatelessWidget {
  final Function onTapBack;
  final MovieVO? movie;

  const MovieDetailsSilverAppBarView(
    this.onTapBack, {
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MOVIE_DETAILS_SCREEN_SLIVER_APP_BAR_HEIGHT,
      backgroundColor: PRIMARY_COLOR,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned.fill(
              child: MovieDetailsAppBarImageView(
                movieImage: movie?.posterPath,
              ),
            ),
            const Positioned.fill(
              child: GradientView(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: MARGIN_XXL_LARGE, left: MARGIN_MEDIUM_2),
                child: BackButtonView(() {
                  onTapBack();
                }),
              ),
            ),
            const Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(
                    top: MARGIN_XXL_LARGE + MARGIN_MEDIUM,
                    right: MARGIN_MEDIUM_2),
                child: SearchButtonView(),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: MARGIN_MEDIUM_2,
                  right: MARGIN_MEDIUM_2,
                  bottom: MARGIN_LARGE,
                ),
                child: MovieDetailsAppBarInfoView(
                  mMovie: movie,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieDetailsAppBarInfoView extends StatelessWidget {
  const MovieDetailsAppBarInfoView({
    Key? key,
    this.mMovie,
  }) : super(key: key);

  final MovieVO? mMovie;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            MovieDetailsYearView(year: mMovie?.releaseDate?.year.toString()),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const RatingView(),
                    const SizedBox(
                      height: MRAGIN_SMALL,
                    ),
                    TitleText(text: '${mMovie?.voteCount ?? ''} VOTES'),
                    const SizedBox(
                      height: MARGIN_CARD_MEDIUM_2,
                    ),
                  ],
                ),
                const SizedBox(
                  width: MARGIN_MEDIUM,
                ),
                Text(
                  '${mMovie?.voteAverage ?? ''}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: MOVIE_DETAILS_RATING_TEXT_SIZE,
                  ),
                ),
              ],
            )
          ],
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Text(
          mMovie?.title ?? "",
          style: const TextStyle(
            color: Colors.white,
            fontSize: TEXT_HEADING_2X,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class MovieDetailsYearView extends StatelessWidget {
  const MovieDetailsYearView({
    Key? key,
    this.year,
  }) : super(key: key);

  final String? year;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      height: MARGIN_XXL_LARGE,
      decoration: BoxDecoration(
        color: PLAY_BUTTON_COLOR,
        borderRadius: BorderRadius.circular(
          MARGIN_LARGE,
        ),
      ),
      child: Center(
        child: Text(
          year ?? "",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class SearchButtonView extends StatelessWidget {
  const SearchButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: MARGIN_XXL_LARGE,
    //   height: MARGIN_XXL_LARGE,
    //   decoration: BoxDecoration(
    //     shape: BoxShape.circle,
    //     color: Colors.black54,
    //   ),
    //   child: Icon(
    //     Icons.search,
    //     color: Colors.white,
    //     size: MARGIN_XL_LARGE,
    //   ),
    // );
    return const Icon(
      Icons.search,
      color: Colors.white,
      size: MARGIN_XL_LARGE,
    );
  }
}

class BackButtonView extends StatelessWidget {
  final Function onTapBack;
  const BackButtonView(
    this.onTapBack, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapBack();
      },
      child: Container(
        width: MARGIN_XXL_LARGE,
        height: MARGIN_XXL_LARGE,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black54,
        ),
        child: const Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: MARGIN_XL_LARGE,
        ),
      ),
    );
  }
}

class MovieDetailsAppBarImageView extends StatelessWidget {
  final String? movieImage;

  const MovieDetailsAppBarImageView({
    Key? key,
    this.movieImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      '$IMAGE_BASE_URL$movieImage',
      fit: BoxFit.cover,
    );
  }
}

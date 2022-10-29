import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/bloc/home_bloc.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/pages/movie_details_page.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/resources/string.dart';
import 'package:movie_app/viewitems/banner_view.dart';
import 'package:movie_app/viewitems/movie_view.dart';
import 'package:movie_app/viewitems/show_case_view.dart';
import 'package:movie_app/widgets/see_more_text.dart';
import 'package:movie_app/widgets/title_text.dart';
import 'package:movie_app/widgets/title_text_with_see_more_view.dart';
import 'package:provider/provider.dart';

import '../widgets/actor_and_creater_section_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          centerTitle: true,
          title: const Text(
            MAIN_SCREEN_APP_BAR_TITLE,
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: const Icon(Icons.menu),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: MARGIN_MEDIUM_2),
              child: Icon(
                Icons.search,
              ),
            ),
          ],
        ),
        body: Container(
          color: HOME_SCREEN_BACKGROUND_COLOR,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Consumer<HomeBloc>(
                  builder: (context, value, child) {
                    return BannerSectionView(
                      onTapBanner: (movie) {
                        _navigateToMovieDetailScreen(context, movie.id);
                      },
                      mPopularMovies:
                          value.mPopularMoviesList?.take(3).toList(),
                    );
                  },
                ),
                const SizedBox(
                  height: MARGIN_LARGE,
                ),
                Consumer<HomeBloc>(builder: (context, value, child) {
                  return BestPopularMovieAndSerialsSectionView(
                    mNowPlayingMovieList: value.mNowPlayingMovieList,
                    (movieId) {
                      _navigateToMovieDetailScreen(context, movieId);
                    },
                  );
                }),
                const SizedBox(
                  height: MARGIN_LARGE,
                ),
                const CheckMovieShowTimeSectionView(),
                const SizedBox(
                  height: MARGIN_LARGE,
                ),
                Consumer<HomeBloc>(builder: (context, value, child) {
                  return GenerSectionView(
                    generalList: value.mGenerList,
                    mMoviesByGeneralList: value.mMovieByGenreList,
                    onTapMovie: (movieId) =>
                        _navigateToMovieDetailScreen(context, movieId),
                    onTapGenre: (genreId) {
                      // debugPrint('genreId :::: $genreId');
                      value.getMoviesByGenreAndRefresh(genreId ?? 0);
                    },
                  );
                }),
                const SizedBox(
                  height: MARGIN_LARGE,
                ),
                Consumer<HomeBloc>(builder: (context, value, child) {
                  return ShowCasesSection(
                    mShowCaseMoveList: value.mShowCaseMoveList,
                  );
                }),
                const SizedBox(
                  height: MARGIN_LARGE,
                ),
                Consumer<HomeBloc>(builder: (context, value, child) {
                  return ActorAndCreatorSectionView(
                    titleText: BEST_ACTOR_TITLE,
                    seeMoreText: BEST_ACTOR_SEE_MORE,
                    mActorList: value.mActors,
                  );
                }),
                const SizedBox(
                  height: MARGIN_LARGE,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToMovieDetailScreen(BuildContext context, int? movieId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MovieDetailsPage(
          movieId: movieId ?? 0,
        ),
      ),
    );
  }
}

class GenerSectionView extends StatelessWidget {
  const GenerSectionView({
    Key? key,
    this.generalList,
    this.mMoviesByGeneralList,
    required this.onTapMovie,
    required this.onTapGenre,
  }) : super(key: key);

  final List<GenreVO>? generalList;
  final List<MovieVO>? mMoviesByGeneralList;
  final Function(int?) onTapMovie;
  final Function(int?) onTapGenre;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: generalList != null
              ? DefaultTabController(
                  length: generalList?.length ?? 0,
                  child: TabBar(
                    onTap: (index) {
                      onTapGenre(generalList?[index].id);
                    },
                    isScrollable: true,
                    indicatorColor: PLAY_BUTTON_COLOR,
                    unselectedLabelColor: HOME_SCREEN_LIST_TITLE_COLOR,
                    tabs: generalList
                            ?.map((e) => Tab(child: Text(e.name ?? '')))
                            .toList() ??
                        [],
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        ),
        Container(
          color: PRIMARY_COLOR,
          padding: const EdgeInsets.only(
            top: MARGIN_MEDIUM_2,
            bottom: MARGIN_LARGE,
          ),
          child: HorizontalMovieListView(movieList: mMoviesByGeneralList,
              (movieId) {
            onTapMovie(movieId);
          }),
        ),
      ],
    );
  }
}

class CheckMovieShowTimeSectionView extends StatelessWidget {
  const CheckMovieShowTimeSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      margin: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      height: SHOWTIME_SECTION_HEIGHT,
      padding: const EdgeInsets.all(MARGIN_LARGE),
      child: Row(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              MAIN_SCREEN_CHECK_MOVIE_SHOW_TIME,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: TEXT_HEADING_1X,
              ),
            ),
            Spacer(),
            SeeMoreText(
              text: MAIN_SCREEN_SEE_MORE,
              textColor: PLAY_BUTTON_COLOR,
            ),
          ],
        ),
        const Spacer(),
        const Icon(
          Icons.location_on_rounded,
          color: Colors.white,
          size: PLAY_BANNER_SIZE,
        ),
      ]),
    );
  }
}

class ShowCasesSection extends StatelessWidget {
  const ShowCasesSection({
    Key? key,
    this.mShowCaseMoveList,
  }) : super(key: key);

  final List<MovieVO>? mShowCaseMoveList;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: TitleTextWithSeeMoreView(
            titleText: SHOW_CASES_TITLE,
            seeMoreText: SHOW_CASE_SEE_MORE,
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Container(
          height: SHOW_CASES_HEIGHT,
          child: mShowCaseMoveList != null
              ? ListView(
                  padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
                  scrollDirection: Axis.horizontal,
                  children: mShowCaseMoveList!
                      .map((movie) => ShowCaseView(movie: movie))
                      .toList())
              : const Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }
}

class BestPopularMovieAndSerialsSectionView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final List<MovieVO>? mNowPlayingMovieList;
  const BestPopularMovieAndSerialsSectionView(
    this.onTapMovie, {
    this.mNowPlayingMovieList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
          child: const TitleText(
            text: MAIN_SCREEN_BEST_POPULAR_MOVIE_AND_SCREEN,
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        HorizontalMovieListView(
          movieList: mNowPlayingMovieList,
          (movieId) {
            onTapMovie(movieId);
          },
        ),
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final List<MovieVO>? movieList;

  const HorizontalMovieListView(
    this.onTapMovie, {
    this.movieList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: movieList != null
          ? ListView.builder(
              padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
              scrollDirection: Axis.horizontal,
              itemCount: movieList!.length,
              itemBuilder: ((context, index) {
                return MovieView(mMovie: movieList![index], (movieId) {
                  onTapMovie(movieId);
                });
              }),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

class BannerSectionView extends StatefulWidget {
  const BannerSectionView({
    Key? key,
    this.mPopularMovies,
    required this.onTapBanner,
  }) : super(key: key);

  final List<MovieVO>? mPopularMovies;
  final Function(MovieVO) onTapBanner;
  @override
  State<BannerSectionView> createState() => _BannerSectionViewState();
}

class _BannerSectionViewState extends State<BannerSectionView> {
  double _position = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: widget.mPopularMovies != null
              ? PageView(
                  onPageChanged: (page) {
                    setState(() {
                      _position = page.toDouble();
                    });
                  },
                  children: widget.mPopularMovies!
                      .map((popularMovie) => BannerView(
                            onTapBanner: () {
                              widget.onTapBanner(popularMovie);
                            },
                            mMovie: popularMovie,
                          ))
                      .toList())
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
        const SizedBox(
          height: MARGIN_CARD_MEDIUM_2,
        ),
        DotsIndicator(
          dotsCount: 3,
          position: _position,
          decorator: const DotsDecorator(
            color: HOME_SCREEN_BANNER_DOTS_INACTIVER_COLOR,
            activeColor: PLAY_BUTTON_COLOR,
          ),
        ),
      ],
    );
  }
}

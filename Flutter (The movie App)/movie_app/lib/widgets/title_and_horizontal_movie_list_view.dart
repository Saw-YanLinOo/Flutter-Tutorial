import 'package:flutter/material.dart';
import 'package:movie_app/components/smart_listview.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/viewitems/movie_view.dart';
import 'package:movie_app/widgets/title_text.dart';

class TitleAndHorizontalMovieListView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final String title;
  final List<MovieVO>? mMovieList;
  final Function onReachListEnd;

  const TitleAndHorizontalMovieListView(
    this.onTapMovie, {
    required this.title,
    this.mMovieList,
    required this.onReachListEnd,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
          child: TitleText(
            text: title,
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        HorizontalMovieListView(
          movieList: mMovieList,
          onReachListEnd: onReachListEnd,
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
  final Function onReachListEnd;

  const HorizontalMovieListView(
    this.onTapMovie, {
    this.movieList,
    required this.onReachListEnd,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: movieList != null
          // ? ListView.builder(
          //     padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
          //     scrollDirection: Axis.horizontal,
          //     itemCount: movieList!.length,
          //     itemBuilder: ((context, index) {
          //       return MovieView(mMovie: movieList![index], (movieId) {
          //         onTapMovie(movieId);
          //       });
          //     }),
          //   )
          ? SmartHorizontalListView(
              padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
              scrollDirection: Axis.horizontal,
              itemCount: movieList!.length,
              itemBuilder: ((context, index) {
                return MovieView(mMovie: movieList![index], (movieId) {
                  onTapMovie(movieId);
                });
              }),
              onReachEnd: onReachListEnd,
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/base_actor_vo.dart';
import 'package:movie_app/data/vos/collection_vo.dart';
import 'package:movie_app/data/vos/credit_vo.dart';
import 'package:movie_app/data/vos/date_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/data/vos/production_company_vo.dart';
import 'package:movie_app/data/vos/production_country_vo.dart';
import 'package:movie_app/data/vos/spoken_language_vo.dart';
import 'package:movie_app/pages/home_page.dart';
import 'package:movie_app/persistence/hive_constants.dart';
import 'package:scoped_model/scoped_model.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(ActorVOAdapter());
  Hive.registerAdapter(BaseActorVOAdapter());
  Hive.registerAdapter(CollectionVOAdapter());
  Hive.registerAdapter(CreditVOAdapter());
  Hive.registerAdapter(DateVOAdapter());
  Hive.registerAdapter(GenreVOAdapter());
  Hive.registerAdapter(MovieVOAdapter());
  Hive.registerAdapter(ProductionCompanyVOAdapter());
  Hive.registerAdapter(ProductionCountryVOAdapter());
  Hive.registerAdapter(SpokenLanguageVOAdapter());

  await Hive.openBox<ActorVO>(BOX_NAME_ACTOR_VO);
  await Hive.openBox<MovieVO>(BOX_NAME_MOVIE_VO);
  await Hive.openBox<GenreVO>(BOX_NAME_GENRE_VO);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: MovieModelImpl(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

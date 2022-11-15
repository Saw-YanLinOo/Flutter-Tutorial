import 'package:movie_app/data/vos/actor_vo.dart';

abstract class ActorDao {
  void saveAllActors(List<ActorVO> actorList);
  List<ActorVO> getAllActor();
}

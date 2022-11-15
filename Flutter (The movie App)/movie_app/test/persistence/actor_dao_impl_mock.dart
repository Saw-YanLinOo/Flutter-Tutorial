import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/persistence/daos/actor_dao.dart';

class ActorDaoImplMock extends ActorDao {
  Map<int, ActorVO> actorListFromDatabaseMock = {};

  @override
  List<ActorVO> getAllActor() {
    return actorListFromDatabaseMock.values.toList();
  }

  @override
  void saveAllActors(List<ActorVO> actorList) {
    for (var actor in actorList) {
      actorListFromDatabaseMock[actor.id ?? 0] = actor;
    }
  }
}

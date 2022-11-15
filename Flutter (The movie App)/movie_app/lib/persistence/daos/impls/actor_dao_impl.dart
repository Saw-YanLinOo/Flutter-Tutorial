import 'package:hive/hive.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/persistence/daos/actor_dao.dart';
import 'package:movie_app/persistence/hive_constants.dart';

class ActorDaoImpl extends ActorDao{
  ActorDaoImpl._internal();

  static final ActorDaoImpl _singleton = ActorDaoImpl._internal();

  factory ActorDaoImpl() => _singleton;

  @override
  void saveAllActors(List<ActorVO> actorList) async {
    Map<int?, ActorVO> actorMap = {
      for (var actor in actorList) actor.id: actor
    };

    await getActorBox().putAll(actorMap);
  }

  @override
  List<ActorVO> getAllActor() {
    return getActorBox().values.toList();
  }

  Box<ActorVO> getActorBox() {
    return Hive.box<ActorVO>(BOX_NAME_ACTOR_VO);
  }

  Future<Box<ActorVO>> openActorBox() {
    return Hive.openBox<ActorVO>(BOX_NAME_ACTOR_VO);
  }
}

import 'package:wechat_redesign/data/vos/group_vo.dart';
import 'package:wechat_redesign/data/vos/message_vo.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';

abstract class MessagingDataAgent {
  Future sendMessage(String sender, String reciver, MessageVO messageVO);
  Stream<List<MessageVO>?> getMessageDetail(String senderId, String reciverId);

  Stream<List<GroupVO>?> getAllGroup();
  Future createGroup(GroupVO group);

  Stream<List<MessageVO>?> getGroupMessage(String groupId);
  Future sendGroupMessage(String groupId, MessageVO messageVO);
}

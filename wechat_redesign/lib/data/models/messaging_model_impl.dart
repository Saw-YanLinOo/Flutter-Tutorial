import 'dart:io';

import 'package:wechat_redesign/data/models/authentication_model.dart';
import 'package:wechat_redesign/data/models/messaging_model.dart';
import 'package:wechat_redesign/data/vos/group_vo.dart';
import 'package:wechat_redesign/data/vos/message_vo.dart';
import 'package:wechat_redesign/data/vos/otp_code_vo.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';
import 'package:wechat_redesign/network/cloud_firestore_data_agent_impl.dart';
import 'package:wechat_redesign/network/messaging_data_agent.dart';
import 'package:wechat_redesign/network/real_time_database_data_agent_impl.dart';
import 'package:wechat_redesign/network/we_chat_data_agent.dart';

class MessagingModelImpl extends MessagingModel {
  MessagingModelImpl._();

  static final MessagingModelImpl _singleton = MessagingModelImpl._();

  factory MessagingModelImpl() => _singleton;

  final WeChatDataAgent dataAgent = CloudFireStoreDataAgentImpl();
  final MessagingDataAgent messageDataAgent = RealTimeDatabaseDataAgent();

  @override
  Stream<List<MessageVO>?> getMessageDetail(String senderId, String reciverId) {
    return messageDataAgent.getMessageDetail(senderId, reciverId).map((event) {
      return event;
    });
  }

  @override
  Future sendMessage(String sender, String reciver, MessageVO messageVO) {
    return messageDataAgent
        .sendMessage(sender, reciver, messageVO)
        .then((value) {
      return messageDataAgent.sendMessage(reciver, sender, messageVO);
    });
  }

  @override
  Future createGroup(GroupVO group) {
    return messageDataAgent.createGroup(group);
  }

  @override
  Future sendGroupMessage(String groupId, MessageVO messageVO, File? file) {
    if (file == null) {
      return messageDataAgent.sendGroupMessage(groupId, messageVO);
    } else {
      return dataAgent.uploadFileToFirebase(file).then((value) {
        messageVO.file = value;
        return messageDataAgent.sendGroupMessage(groupId, messageVO);
      });
    }
  }

  @override
  Stream<List<GroupVO>?> getAllGroup() {
    return messageDataAgent.getAllGroup();
  }

  @override
  Stream<List<MessageVO>?> getGroupMessage(String groupId) {
    return messageDataAgent.getGroupMessage(groupId);
  }

  @override
  Future sendMessageWithFile(
      String sender, String reciver, MessageVO messageVO, File file) {
    return dataAgent.uploadFileToFirebase(file).then((value) {
      messageVO.file = value;
      return sendMessage(sender, reciver, messageVO);
    });
  }
}

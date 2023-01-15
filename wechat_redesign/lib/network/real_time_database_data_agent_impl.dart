import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:wechat_redesign/data/vos/group_vo.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';
import 'package:wechat_redesign/data/vos/message_vo.dart';
import 'package:wechat_redesign/network/messaging_data_agent.dart';

const String contantsAndMessages = 'contantsAndMessages';
const String groupPath = 'groups';
const String messagePath = 'messages';

class RealTimeDatabaseDataAgent extends MessagingDataAgent {
  RealTimeDatabaseDataAgent._();

  static final RealTimeDatabaseDataAgent _singleton =
      RealTimeDatabaseDataAgent._();

  factory RealTimeDatabaseDataAgent() => _singleton;

  // Firebase Instance
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;
  final databaseRef = FirebaseDatabase.instance.ref();

  @override
  Future sendMessage(String sender, String reciver, MessageVO messageVO) {
    return databaseRef
        .child(contantsAndMessages)
        .child('${sender}')
        .child('${reciver}')
        .child('${messageVO.id}')
        .set(messageVO.toJson())
        .then((value) => debugPrint("success"))
        .onError((error, stackTrace) => debugPrint('Error::$error'));
  }

  @override
  Stream<List<MessageVO>?> getMessageDetail(String senderId, String reciverId) {
    return databaseRef
        .child(contantsAndMessages)
        .child('${senderId}')
        .child('${reciverId}')
        .onValue
        .map((event) {
      return (event.snapshot.value as Map<dynamic, dynamic>)
          .values
          .map<MessageVO>((e) {
        return MessageVO.fromJson(Map<String, dynamic>.from(e));
      }).toList();
    });
  }

  @override
  Future createGroup(GroupVO group) {
    return databaseRef
        .child(groupPath)
        .child('${group.id}')
        .set(group.toJson());
  }

  @override
  Future sendGroupMessage(String groupId, MessageVO messageVO) {
    return databaseRef
        .child(groupPath)
        .child(groupId)
        .child(messagePath)
        .child('${messageVO.id}')
        .set(messageVO.toJson());
  }

  @override
  Stream<List<GroupVO>?> getAllGroup() {
    return databaseRef.child(groupPath).onValue.map((event) {
      return (event.snapshot.value as Map<dynamic, dynamic>)
          .values
          .map<GroupVO>((e) {
        return GroupVO.fromJson(Map<String, dynamic>.from(e));
      }).toList();
    });
  }

  @override
  Stream<List<MessageVO>?> getGroupMessage(String groupId) {
    return databaseRef
        .child(groupPath)
        .child('${groupId}')
        .child('${messagePath}')
        .onValue
        .map((event) {
      return (event.snapshot.value as Map<dynamic, dynamic>)
          .values
          .map<MessageVO>((e) {
        return MessageVO.fromJson(Map<String, dynamic>.from(e));
      }).toList();
    });
  }
}

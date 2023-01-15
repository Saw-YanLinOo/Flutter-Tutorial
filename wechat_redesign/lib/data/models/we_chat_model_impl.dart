import 'dart:io';

import 'package:wechat_redesign/data/models/authentication_model.dart';
import 'package:wechat_redesign/data/models/authentication_model_impl.dart';
import 'package:wechat_redesign/data/models/we_chat_model.dart';
import 'package:wechat_redesign/data/vos/moment_vo.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';
import 'package:wechat_redesign/network/cloud_firestore_data_agent_impl.dart';
import 'package:wechat_redesign/network/we_chat_data_agent.dart';

class WeChatModelImpl extends WeChatModel {
  WeChatModelImpl._();

  static final WeChatModelImpl _singleton = WeChatModelImpl._();

  factory WeChatModelImpl() => _singleton;

  final WeChatDataAgent dataAgent = CloudFireStoreDataAgentImpl();
  final AuthenticationModel authModel = AuthenticationModelImpl();

  @override
  Future<void> addNewMoment(String description, List<File>? files) {
    if (files != null && files.isNotEmpty) {
      return uploadMultipleFile(files).then((urls) {
        return crafNewMomentVO(description, urls);
      }).then((value) {
        return dataAgent.addNewMoment(value);
      });
    } else {
      return crafNewMomentVO(description, []).then((value) {
        return dataAgent.addNewMoment(value);
      });
    }
  }

  Future<MomentVO> crafNewMomentVO(String description, List<String> imageUrl) {
    var time = DateTime.now().microsecondsSinceEpoch;

    var newFeed = MomentVO(
      id: time,
      description: description,
      postImages: imageUrl,
      timeStamp: '${DateTime.now()}',
      profilePicture: authModel.getLoggedInUser().profilePhoto,
      userName: authModel.getLoggedInUser().userName,
    );
    return Future.value(newFeed);
  }

  Future<List<String>> uploadMultipleFile(List<File> files) async {
    List<String> downloadFileList = [];

    // files.map((file) async {
    //   var url = await dataAgent.uploadFileToFirebase(file);
    //   return url;
    // });

    downloadFileList = await Future.wait(
      files.map((file) async {
        var url = await dataAgent.uploadFileToFirebase(file);
        return url;
      }),
    );
    return Future.value(downloadFileList);
  }

  @override
  Future<void> deleteNewMoment(int postId) {
    return dataAgent.deleteNewMoment(postId);
  }

  @override
  Future<void> editNewMoment(MomentVO newMoment, List<File>? file) {
    return dataAgent.addNewMoment(newMoment);
  }

  @override
  Stream<List<MomentVO>> getNewMoment() {
    return dataAgent.getNewMoment();
  }

  @override
  Stream<MomentVO> getNewMomentById(int postId) {
    return dataAgent.getNewMomentById(postId);
  }

  @override
  Future<UserVO?> getUserFromDatabse(String uid) {
    return dataAgent.getUserFromDatabse(uid);
  }

  @override
  Future<void> addNewContant(UserVO sender, UserVO reciver) {
    return dataAgent.addNewContant(sender, reciver).then((value) {
      return dataAgent.addNewContant(reciver, sender);
    });
  }

  @override
  Stream<List<UserVO>?> getUserContant(String uid) {
    return dataAgent.getUserContant(uid);
  }

  @override
  Future<void> updateUserActiveTime() {
    return getUserFromDatabse(authModel.getLoggedInUser().id ?? '')
        .then((user) {
      user?.activeTime = DateTime.now().toIso8601String();
    });
  }
}

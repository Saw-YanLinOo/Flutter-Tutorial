import 'dart:io';

import 'package:wechat_redesign/data/vos/moment_vo.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';

abstract class WeChatModel {
  Stream<List<MomentVO>> getNewMoment();
  Future<void> addNewMoment(String description, List<File>? files);
  Future<void> deleteNewMoment(int postId);
  Stream<MomentVO> getNewMomentById(int postId);
  Future<void> editNewMoment(MomentVO newMoment, List<File>? file);
  Future<UserVO?> getUserFromDatabse(String uid);
  Future<void> addNewContant(UserVO sender, UserVO reciver);
  Stream<List<UserVO>?> getUserContant(String uid);

  Future<void> updateUserActiveTime();
}

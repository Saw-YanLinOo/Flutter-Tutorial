import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:wechat_redesign/data/models/authentication_model_impl.dart';
import 'package:wechat_redesign/data/models/messaging_model.dart';
import 'package:wechat_redesign/data/models/messaging_model_impl.dart';
import 'package:wechat_redesign/data/models/we_chat_model_impl.dart';
import 'package:wechat_redesign/data/vos/group_vo.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';
import 'package:wechat_redesign/dummy_data/dummy_data.dart';

class AddNewGroupBloc extends ChangeNotifier {
  bool isDisposed = false;
  bool isLoading = false;

  String? groupName = '';
  List<UserVO>? userList;

  List<UserVO> choosenUsers = [];

  final weChatModel = WeChatModelImpl();
  final authModel = AuthenticationModelImpl();
  final messageModel = MessagingModelImpl();

  AddNewGroupBloc() {
    weChatModel
        .getUserContant(authModel.getLoggedInUser().id ?? '')
        .listen((users) {
      userList = users;
      notifySafely();
    });
  }

  Future onTapCreated() {
    setLoading(true);

    if (groupName == '' || choosenUsers.isEmpty) {
      setLoading(false);
      return Future.error('Enter all field');
    }

    var group = crafnewGroup();

    return messageModel
        .createGroup(group)
        .then((value) => setLoading(false))
        .onError((error, stackTrace) => setLoading(false));
  }

  GroupVO crafnewGroup() {
    var uids = [authModel.getLoggedInUser().id ?? ''];
    uids.addAll(choosenUsers.map((e) => e.id ?? '').toList());

    var group = GroupVO(
      id: Uuid().v4(),
      name: groupName,
      groupPhoto: getRandomImageUrl(),
      ids: uids,
      timeStamp: '${DateTime.now()}',
    );
    return group;
  }

  void onChangedCheckBox(bool check, UserVO user) {
    if (check) {
      choosenUsers.add(user);
    } else {
      choosenUsers.remove(user);
    }
    notifySafely();
  }

  void onChangedGroupName(String value) {
    groupName = value;
    notifySafely();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifySafely();
  }

  void notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    isDisposed = true;
  }
}

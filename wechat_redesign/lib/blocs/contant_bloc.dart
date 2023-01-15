import 'package:flutter/cupertino.dart';
import 'package:wechat_redesign/data/models/authentication_model_impl.dart';
import 'package:wechat_redesign/data/models/messaging_model_impl.dart';
import 'package:wechat_redesign/data/models/we_chat_model_impl.dart';
import 'package:wechat_redesign/data/vos/group_vo.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';

class ContantBloc extends ChangeNotifier {
  bool isDisposed = false;

  List<UserVO>? userList;
  List<GroupVO>? groupList;

  final weChatModel = WeChatModelImpl();
  final authModel = AuthenticationModelImpl();
  final messageModel = MessagingModelImpl();

  ContantBloc() {
    weChatModel
        .getUserContant(authModel.getLoggedInUser().id ?? '')
        .listen((users) {
      debugPrint('user contant ::${users?.first.toString()}');
      userList = users;
      notifySafely();
    });

    messageModel.getAllGroup().listen((event) {
      var filter = event
          ?.where(
              (e) => e.ids?.contains(authModel.getLoggedInUser().id) ?? false)
          .toList();
      groupList = filter;
      notifySafely();
    });
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

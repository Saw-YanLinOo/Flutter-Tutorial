import 'package:flutter/cupertino.dart';
import 'package:wechat_redesign/data/models/authentication_model_impl.dart';
import 'package:wechat_redesign/data/models/messaging_model_impl.dart';
import 'package:wechat_redesign/data/models/we_chat_model_impl.dart';
import 'package:wechat_redesign/data/vos/group_vo.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';

class ChatBloc extends ChangeNotifier {
  bool isDisposed = false;

  List<UserVO>? userList;

  final weChatModel = WeChatModelImpl();
  final authModel = AuthenticationModelImpl();
  final messageModel = MessagingModelImpl();

  ChatBloc() {
    weChatModel
        .getUserContant(authModel.getLoggedInUser().id ?? '')
        .listen((users) {
      userList = users;
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

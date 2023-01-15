import 'package:flutter/cupertino.dart';
import 'package:wechat_redesign/data/models/authentication_model.dart';
import 'package:wechat_redesign/data/models/authentication_model_impl.dart';
import 'package:wechat_redesign/data/models/we_chat_model.dart';
import 'package:wechat_redesign/data/models/we_chat_model_impl.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';

class MeBloc extends ChangeNotifier {
  bool isDisposed = false;

  UserVO? mUser;

  final AuthenticationModel authModel = AuthenticationModelImpl();
  final WeChatModel weChatModel = WeChatModelImpl();

  MeBloc() {
    debugPrint('${authModel.getLoggedInUser().id}');
    weChatModel
        .getUserFromDatabse(authModel.getLoggedInUser().id ?? '')
        .then((user) {
      mUser = user;
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

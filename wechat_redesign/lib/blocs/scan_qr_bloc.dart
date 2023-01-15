import 'package:flutter/cupertino.dart';
import 'package:wechat_redesign/data/models/authentication_model.dart';
import 'package:wechat_redesign/data/models/authentication_model_impl.dart';
import 'package:wechat_redesign/data/models/we_chat_model.dart';
import 'package:wechat_redesign/data/models/we_chat_model_impl.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';

class ScanQrBloc extends ChangeNotifier {
  bool isDisposed = false;
  bool isLoading = false;

  UserVO? currentUser;

  final WeChatModel weChatModel = WeChatModelImpl();
  final AuthenticationModel authModel = AuthenticationModelImpl();

  ScanQrBloc() {
    weChatModel
        .getUserFromDatabse(authModel.getLoggedInUser().id ?? '')
        .then((value) {
      currentUser = value;
    });
  }

  Future addNewContant(String reciverId) {
    setLoading(true);
    return weChatModel.getUserFromDatabse(reciverId).then((reciverUser) {
      if (currentUser != null && reciverUser != null) {
        return weChatModel
            .addNewContant(currentUser!, reciverUser)
            .then((value) => setLoading(false))
            .onError((error, stackTrace) => setLoading(false));
      } else {
        setLoading(false);
        return Future.error('User Not Exit');
      }
    });
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

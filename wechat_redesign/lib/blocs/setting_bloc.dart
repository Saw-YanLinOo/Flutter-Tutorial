import 'package:flutter/cupertino.dart';
import 'package:wechat_redesign/data/models/authentication_model.dart';
import 'package:wechat_redesign/data/models/authentication_model_impl.dart';

class SettingBloc extends ChangeNotifier {
  final AuthenticationModel authModel = AuthenticationModelImpl();

  Future onTapLogout() {
    return authModel.logOut();
  }
}

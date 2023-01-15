import 'package:flutter/cupertino.dart';
import 'package:wechat_redesign/data/models/authentication_model.dart';
import 'package:wechat_redesign/data/models/authentication_model_impl.dart';

class LoginBloc extends ChangeNotifier {
  String email = '';
  String password = '';
  bool isLoading = false;
  final AuthenticationModel authModel = AuthenticationModelImpl();

  Future onTapLogin() {
    setLoading(true);
    return authModel.login(email, password).then((value) {
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
    });
  }

  void setEmail(String value) {
    email = value;
  }

  void setPassword(String value) {
    password = value;
  }

  void setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }
}

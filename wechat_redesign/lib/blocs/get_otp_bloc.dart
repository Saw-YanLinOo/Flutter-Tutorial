import 'package:flutter/cupertino.dart';
import 'package:wechat_redesign/data/models/authentication_model.dart';
import 'package:wechat_redesign/data/models/authentication_model_impl.dart';

class GetOtpBloc extends ChangeNotifier {
  bool isDisposed = false;
  bool isLoading = false;

  String? phone = '';
  String? code = '';

  final AuthenticationModel auth = AuthenticationModelImpl();

  void onChangedPhone(String? value) {
    phone = value;
    notifysafely();
  }

  void onChangedCode(String? value) {
    code = value;
    notifysafely();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifysafely();
  }

  Future onTapVerify() async {
    setLoading(true);

    if (phone == '' && code == '') {
      setLoading(false);
      return Future.error('Enter Phone Number');
    }

    var otp = await auth.getOTP();

    setLoading(false);
    if (otp.code == code) {
      return Future.value('success');
    } else {
      return Future.error('Code No Match');
    }
  }

  void notifysafely() {
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

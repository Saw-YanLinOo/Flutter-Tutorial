import 'package:flutter/cupertino.dart';
import 'package:wechat_redesign/data/models/authentication_model.dart';
import 'package:wechat_redesign/data/models/authentication_model_impl.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';
import 'package:wechat_redesign/dummy_data/dummy_data.dart';
import 'package:wechat_redesign/pages/register_page.dart';

class RegisterBloc extends ChangeNotifier {
  bool agreeTerm = false;
  bool isDisposed = false;
  int groupValue = 0;
  String? name = '';
  String? password = '';
  String? email = '';
  String? phone = '';

  String day = 'Day';
  String month = 'Month';
  String year = 'Year';

  bool isLoading = false;

  final AuthenticationModel authModel = AuthenticationModelImpl();

  RegisterBloc({String? phoneNumber}) {
    phone = phoneNumber;
  }

  Future onTapSignUp() {
    setLoading(true);
    if (name == '' ||
        password == '' ||
        email == '' ||
        day == 'Day' ||
        month == 'Month' ||
        year == "Year" ||
        agreeTerm == false) {
      setLoading(false);
      return Future.error('Enter all correct value');
    }

    var user = UserVO(
      userName: name,
      email: email,
      password: password,
      profilePhoto: getRandomImageUrl(),
      dateOfBirth: '$day/$month/$year',
      gender: GenderItem.values[groupValue].name,
      phoneNumber: phone,
    );

    // debugPrint(user.toString());
    return authModel
        .register(user)
        .then((value) => setLoading(false))
        .onError((error, stackTrace) => setLoading(false));
  }

  void setDay(String value) {
    day = value;
    notifySafely();
  }

  void setMonth(String value) {
    month = value;
    notifySafely();
  }

  void setYear(String value) {
    year = value;
    notifySafely();
  }

  void setName(String value) {
    name = value;
  }

  void setPassword(String value) {
    password = value;
  }

  void setEmail(String value) {
    email = value;
  }

  void setAgreeTerm() {
    agreeTerm = true;
    notifySafely();
  }

  void setGroupValue(int value) {
    groupValue = value;
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

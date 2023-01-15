import 'package:wechat_redesign/data/vos/user_vo.dart';

import '../vos/otp_code_vo.dart';

abstract class AuthenticationModel {
  Future<void> login(String email, String password);
  Future<void> register(UserVO user);
  bool isLoggedIn();
  UserVO getLoggedInUser();
  Future logOut();

  Future<OtpCodeVO> getOTP();
}

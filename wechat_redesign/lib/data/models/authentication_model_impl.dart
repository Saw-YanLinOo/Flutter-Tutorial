import 'package:wechat_redesign/data/models/authentication_model.dart';
import 'package:wechat_redesign/data/vos/otp_code_vo.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';
import 'package:wechat_redesign/network/cloud_firestore_data_agent_impl.dart';
import 'package:wechat_redesign/network/we_chat_data_agent.dart';

class AuthenticationModelImpl extends AuthenticationModel {
  AuthenticationModelImpl._();

  static final AuthenticationModelImpl _singleton = AuthenticationModelImpl._();

  factory AuthenticationModelImpl() => _singleton;

  final WeChatDataAgent dataAgent = CloudFireStoreDataAgentImpl();

  @override
  UserVO getLoggedInUser() {
    return dataAgent.getLoggedInUser();
  }

  @override
  bool isLoggedIn() {
    return dataAgent.isLoggedIn();
  }

  @override
  Future logOut() {
    return dataAgent.logOut();
  }

  @override
  Future<void> login(String email, String password) {
    return dataAgent.login(email, password);
  }

  @override
  Future<void> register(UserVO user) {
    return dataAgent.registerNewUser(user);
  }

  @override
  Future<OtpCodeVO> getOTP() {
    return dataAgent.getOTP();
  }
}

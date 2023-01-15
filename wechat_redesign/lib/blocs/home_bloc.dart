import 'package:flutter/cupertino.dart';
import 'package:wechat_redesign/pages/chat_page.dart';
import 'package:wechat_redesign/pages/contant_page.dart';
import 'package:wechat_redesign/pages/moment_page.dart';
import 'package:wechat_redesign/pages/me_page.dart';
import 'package:wechat_redesign/pages/setting_page.dart';

class HomeBloc extends ChangeNotifier {
  bool isDisposed = false;

  final pages = [
    MomentPage(),
    ChatPage(),
    ContantPage(),
    MePage(),
    SettingPage(),
  ];

  int currentIndex = 0;

  void changeIndex(int value) {
    currentIndex = value;
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

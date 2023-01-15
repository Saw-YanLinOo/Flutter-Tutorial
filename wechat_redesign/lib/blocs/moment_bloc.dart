import 'package:flutter/cupertino.dart';
import 'package:wechat_redesign/data/models/we_chat_model.dart';
import 'package:wechat_redesign/data/models/we_chat_model_impl.dart';
import 'package:wechat_redesign/data/vos/moment_vo.dart';

class MomentBloc extends ChangeNotifier {
  bool isDisposed = false;
  List<MomentVO>? moments;

  final WeChatModel weChatModel = WeChatModelImpl();

  MomentBloc() {
    weChatModel.getNewMoment().listen((momentList) {
      moments = momentList;
      notifySafely();
    });
  }

  Future onTapDelete(int postId) {
    return weChatModel.deleteNewMoment(postId);
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

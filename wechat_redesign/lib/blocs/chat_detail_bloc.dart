import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:wechat_redesign/data/models/authentication_model.dart';
import 'package:wechat_redesign/data/models/authentication_model_impl.dart';
import 'package:wechat_redesign/data/models/messaging_model.dart';
import 'package:wechat_redesign/data/models/messaging_model_impl.dart';
import 'package:wechat_redesign/data/vos/message_vo.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';
import 'package:wechat_redesign/pages/chat_detail_page.dart';

enum MessageType {
  text,
  image,
  video,
  voice,
}

class ChatDetailBloc extends ChangeNotifier {
  bool isDisposed = false;
  bool isLoading = false;

  UserVO? currentUser;
  String? reciver;
  List<MessageVO>? messageList;
  String? message;
  ChatAction? activeAction = ChatAction.Text;
  MessageVO? tempFileMessage;

  final MessagingModel messageModel = MessagingModelImpl();
  final AuthenticationModel authModel = AuthenticationModelImpl();

  ChatDetailBloc(String? revicerId) {
    currentUser = authModel.getLoggedInUser();

    if (revicerId != null) {
      reciver = revicerId;
      messageModel
          .getMessageDetail(authModel.getLoggedInUser().id ?? '', revicerId)
          .listen((event) {
        event?.sort((a, b) => a.timeStamp!.compareTo(b.timeStamp!));

        messageList = event?.reversed.toList();
        notifySafely();
      });
    }
  }

  Future sendMessage() {
    if (activeAction == ChatAction.Text) {
      return sendTextMessage();
    } else {
      return sendFileMessage()
          .then((value) => setActiveAction(ChatAction.Text));
    }
  }

  Future sendTextMessage() {
    if (message == null) {
      return Future.error('Enter Message');
    }

    var messageVO = craftTextMessageVO();
    return messageModel
        .sendMessage(currentUser?.id ?? '', reciver ?? '', messageVO)
        .then((value) {
      message = '';
      notifySafely();
    });
  }

  MessageVO craftTextMessageVO() {
    return MessageVO(
      id: Uuid().v4(),
      message: message,
      timeStamp: DateTime.now().toIso8601String(),
      userId: currentUser?.id,
      userName: currentUser?.userName,
      profilePhoto: currentUser?.profilePhoto,
    );
  }

  Future sendFileMessage() {
    setLoading(true);
    var messageVO = craftFileMessage();
    return messageModel
        .sendMessageWithFile(currentUser?.id ?? '', reciver ?? '', messageVO,
            File('${messageVO.file}'))
        .then((value) => setLoading(false))
        .onError((error, stackTrace) => setLoading(false));
  }

  MessageVO craftFileMessage() {
    return MessageVO(
      id: Uuid().v4(),
      message: tempFileMessage?.messageType,
      timeStamp: DateTime.now().toIso8601String(),
      userId: currentUser?.id,
      userName: currentUser?.userName,
      profilePhoto: currentUser?.profilePhoto,
      messageType: tempFileMessage?.messageType,
      file: tempFileMessage?.file,
      fileType: tempFileMessage?.fileType,
    );
  }

  void setTempMessage(String fileType, String path) {
    tempFileMessage = MessageVO();

    debugPrint('File path ::: $path');
    if (fileType == "jpg" ||
        fileType == "png" ||
        fileType == "jpeg" ||
        fileType == ".jpg" ||
        fileType == "gif") {
      tempFileMessage?.messageType = MessageType.image.name;
    } else if (fileType == "mp4") {
      tempFileMessage?.messageType = MessageType.video.name;
    } else {
      tempFileMessage?.messageType = MessageType.text.name;
    }

    tempFileMessage?.fileType = fileType;
    tempFileMessage?.file = path;
    notifySafely();
  }

  void setActiveAction(ChatAction? action) {
    activeAction = action;
    notifySafely();
  }

  void onChangedMessage(String value) {
    message = value;
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

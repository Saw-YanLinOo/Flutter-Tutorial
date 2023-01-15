import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wechat_redesign/data/models/authentication_model.dart';
import 'package:wechat_redesign/data/models/authentication_model_impl.dart';
import 'package:wechat_redesign/data/models/we_chat_model.dart';
import 'package:wechat_redesign/data/models/we_chat_model_impl.dart';
import 'package:wechat_redesign/data/vos/moment_vo.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';
import 'package:wechat_redesign/network/we_chat_data_agent.dart';

const localKey = 'local';
const networkKey = 'network';

class AddMomentBloc extends ChangeNotifier {
  bool error = false;
  bool loading = false;
  bool isDisposed = false;
  bool editMode = false;

  String? description = '';

  List<File> chooseImageList = [];

  String? userName;
  String? profilePicture;
  List<String>? postImages = [];
  MomentVO? newMovement;

  UserVO? _loginUser;

  // Model
  final AuthenticationModel authModel = AuthenticationModelImpl();
  final WeChatModel weChatModel = WeChatModelImpl();

  AddMomentBloc(int? movementId) {
    _loginUser = authModel.getLoggedInUser();

    if (movementId != null) {
      editMode = true;
      _prePopulateDataForEditMode(movementId);
    } else {
      editMode = false;
      _prePopulateDataForAddMode();
    }
  }

  Future onTapCreate() {
    setLoading(true);
    if (description == '') {
      setLoading(false);
      return Future.error('Enter descritpion');
    }

    if (editMode) {
      newMovement?.description = description;
      return weChatModel
          .editNewMoment(newMovement ?? MomentVO(), [])
          .then((value) => setLoading(false))
          .onError((error, stackTrace) => setLoading(false));
    } else {
      return weChatModel
          .addNewMoment(description ?? '', chooseImageList)
          .then((value) {
        setLoading(false);
      }).onError((error, stackTrace) {
        setLoading(false);
      });
    }
  }

  void _prePopulateDataForAddMode() async {
    userName = _loginUser?.userName;
    profilePicture = _loginUser?.profilePhoto;
    notifySafely();
  }

  void _prePopulateDataForEditMode(int momentId) {
    weChatModel.getNewMomentById(momentId).listen((moment) {
      debugPrint('moment ::: ${moment.toString()}');
      userName = moment.userName;
      profilePicture = moment.profilePicture;
      description = moment.description;
      postImages = moment.postImages;
      newMovement = moment;
      notifySafely();
    });
  }

  void setLoading(bool value) {
    loading = value;
    notifySafely();
  }

  void setDescription(String value) {
    description = value;
  }

  void setChooseImageList(List<XFile> imageList) {
    for (var xImage in imageList) {
      chooseImageList.add(File(xImage.path));
    }

    notifySafely();
  }

  void removeChooseImage(int index) {
    chooseImageList.removeAt(index);
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

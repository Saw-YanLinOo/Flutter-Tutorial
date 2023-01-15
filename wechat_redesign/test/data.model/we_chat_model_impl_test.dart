import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wechat_redesign/data/models/we_chat_model_impl.dart';

import '../mock_data/mock_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  group('We Chat Model Impl', () {
    var model = WeChatModelImpl();

    test('upload multiple file to firebase', () {
      expect([''], model.uploadMultipleFile(fileList));
    });
  });
}

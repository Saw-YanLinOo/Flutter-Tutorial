import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:wechat_redesign/data/vos/moment_vo.dart';
import 'package:wechat_redesign/data/vos/otp_code_vo.dart';
import 'package:wechat_redesign/data/vos/user_vo.dart';
import 'package:wechat_redesign/network/we_chat_data_agent.dart';

const newMomentCollection = 'moments';
const String userPath = 'users';
const String authPath = 'auth';
const fileBrucketName = 'uploads';
const String userContantPath = 'contants';

class CloudFireStoreDataAgentImpl extends WeChatDataAgent {
  CloudFireStoreDataAgentImpl._();

  static final CloudFireStoreDataAgentImpl _singleton =
      CloudFireStoreDataAgentImpl._();

  factory CloudFireStoreDataAgentImpl() => _singleton;

  // Firebase Instance
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;

  @override
  UserVO getLoggedInUser() {
    return UserVO(
      id: auth.currentUser?.uid,
      email: auth.currentUser?.email,
      userName: auth.currentUser?.displayName,
      profilePhoto: auth.currentUser?.photoURL,
    );
  }

  @override
  Future<OtpCodeVO> getOTP() {
    return fireStore
        .collection(authPath)
        .doc('otp-code')
        .get()
        .then((document) {
      return OtpCodeVO.fromJson(document.data() ?? {});
    });
  }

  @override
  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  @override
  Future logOut() {
    return auth.signOut();
  }

  @override
  Future login(String email, String password) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future registerNewUser(UserVO newUser) {
    return auth
        .createUserWithEmailAndPassword(
            email: newUser.email ?? '', password: newUser.password ?? '')
        .then((credential) {
      return credential.user
        ?..updateDisplayName(newUser.userName)
        ..updateEmail(newUser.email ?? '')
        ..updatePhotoURL(newUser.profilePhoto);
    }).then((user) {
      newUser.id = user?.uid;
      addNewUser(newUser);
    });
  }

  Future<void> addNewUser(UserVO newUser) {
    return fireStore
        .collection(userPath)
        .doc('${newUser.id}')
        .set(newUser.toJson());
  }

  @override
  Future<void> addNewMoment(MomentVO newMoment) {
    return fireStore
        .collection(newMomentCollection)
        .doc('${newMoment.id}')
        .set(newMoment.toJson());
  }

  @override
  Future<void> deleteNewMoment(int postId) {
    return fireStore.collection(newMomentCollection).doc('$postId').delete();
  }

  @override
  Stream<List<MomentVO>> getNewMoment() {
    return fireStore
        .collection(newMomentCollection)
        .snapshots()
        .map((querySnapShot) {
      return querySnapShot.docs.map<MomentVO>((document) {
        return MomentVO.fromJson(document.data());
      }).toList();
    });
  }

  @override
  Stream<MomentVO> getNewMomentById(int postId) {
    return fireStore
        .collection(newMomentCollection)
        .doc('$postId')
        .get()
        .asStream()
        .where((event) => event.data() != null)
        .map((document) {
      return MomentVO.fromJson(document.data()!);
    });
  }

  @override
  Future<String> uploadFileToFirebase(File file) {
    return firebaseStorage
        .ref(fileBrucketName)
        .child(const Uuid().v4())
        .putFile(file)
        .then((snapShot) => snapShot.ref.getDownloadURL());
  }

  @override
  Future<UserVO?> getUserFromDatabse(String uid) {
    return fireStore
        .collection(userPath)
        .doc(uid)
        .get()
        .then((value) => UserVO.fromJson(value.data() ?? {}));
  }

  @override
  Future<void> addNewContant(UserVO sender, UserVO reciver) {
    return fireStore
        .collection(userPath)
        .doc('${sender.id}')
        .collection(userContantPath)
        .doc('${reciver.id}')
        .set(reciver.toJson());
  }

  @override
  Stream<List<UserVO>?> getUserContant(String uid) {
    return fireStore
        .collection(userPath)
        .doc(uid)
        .collection(userContantPath)
        .snapshots()
        .map((querySnapShot) {
      return querySnapShot.docs.map<UserVO>((document) {
        return UserVO.fromJson(document.data());
      }).toList();
    });
  }
}

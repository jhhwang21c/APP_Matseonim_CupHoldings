import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// 사용자 계정의 로그인 또는 회원가입 결과를 나타내는 열거형.
enum AuthStatus {
  success,
  emailAlreadyInUse,
  invalidEmail,
  requiresRecentLogin,
  unknownError,
  userNotFound,
  weakPassword,
  wrongPassword
}

/// 사용자의 계정 정보를 나타내는 클래스.
class MSIUser {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? uid, name, email, password, phoneNumber;
  String? profession, interest, avatarUrl, baseName;

  MSIUser({
    this.uid,
    this.name,
    this.email,
    this.password,
    this.phoneNumber,
    this.profession,
    this.interest,
    this.avatarUrl,
    this.baseName
  });

  /// 사용자 정보를 초기화한다.
  static Future<MSIUser> init({String? uid}) async {
    MSIUser result = MSIUser(uid: uid);

    await result._init();

    return result;
  }

  /// 이메일과 비밀번호로 로그인을 시도한다.
  Future<AuthStatus> login() async {
    try {
      UserCredential _ = await _auth.signInWithEmailAndPassword(
        email: email ?? "", 
        password: password ?? ""
      );

      await _init();

      return AuthStatus.success;
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        return AuthStatus.invalidEmail;
      } else if (e.code == "user-not-found") {
        return AuthStatus.userNotFound;
      } else if (e.code == "wrong-password") {
        return AuthStatus.wrongPassword;
      }
    }

    return AuthStatus.unknownError;
  }

  /// 현재 로그인되어 있는 계정에서 로그아웃한다.
  Future<void> logout() async {
    await _auth.signOut();
  }

  /// 이메일과 비밀번호로 회원가입을 진행한다.
  Future<AuthStatus> signUp() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email ?? "", 
        password: password ?? ""
      );

      await _init();
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return AuthStatus.emailAlreadyInUse;
      } else if (e.code == "invalid-email") {
        return AuthStatus.invalidEmail;
      } else if (e.code == "weak-password") {
        return AuthStatus.weakPassword;
      }
    }

    return AuthStatus.unknownError;
  }

  /// 현재 로그인되어 있는 계정의 비밀번호를 변경한다.
  Future<AuthStatus> changePassword({
    required String oldPassword, 
    required String newPassword
  }) async {
    try {
      UserCredential _ = await _auth.signInWithEmailAndPassword(
        email: email ?? "", 
        password: oldPassword
      );

      await _auth.currentUser?.updatePassword(newPassword);

      return AuthStatus.success;
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        return AuthStatus.invalidEmail;
      } else if (e.code == "requires-recent-login") {    
        return AuthStatus.requiresRecentLogin;
      } else if (e.code == "user-not-found") {
        return AuthStatus.userNotFound;
      } else if (e.code == "weak-password") {
        return AuthStatus.weakPassword;
      } else if (e.code == "wrong-password") {
        return AuthStatus.wrongPassword;
      }
    }

    return AuthStatus.unknownError;
  }

  /// 서버에 저장된 사용자 정보를 업데이트한다.
  Future<void> update() async {
    CollectionReference users = _firestore.collection("users");

    await users.doc(uid).update({
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "profession": profession,
      "interest": interest,
      "avatarUrl": avatarUrl,
      "baseName": baseName
    });
  }

  /// 현재 로그인되어 있는 계정을 삭제하고 로그아웃한다.
  Future<void> delete() async {
    if (uid != _auth.currentUser!.uid) return;

    _auth.currentUser?.delete().then(
      (_) {
        CollectionReference users = _firestore.collection("users");
        users.doc(uid).delete();
      }
    );
  }

  /// 사용자의 고유 ID를 이용하여, 사용자 정보를 서버에서 불러온다.
  Future<void> _init() async {
    uid ??= _auth.currentUser!.uid;

    CollectionReference users = _firestore.collection("users");

    await _initFromDocument(await users.doc(uid).get());
  }

  /// 문서 스냅샷을 이용하여, 사용자 정보를 불러온다.
  Future<void> _initFromDocument(DocumentSnapshot document) async {
    if (!document.exists) {
      await document.reference.set({
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "profession": profession,
        "interest": interest,
        "avatarUrl": null,
        "baseName": null
      });
    }

    name = document["name"];
    email = document["email"];
    phoneNumber = document["phoneNumber"];
    profession = document["profession"];
    interest = document["interest"];
    avatarUrl = document["avatarUrl"];
    baseName = document["baseName"];
  }
}

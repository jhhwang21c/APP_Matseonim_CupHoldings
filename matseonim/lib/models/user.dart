import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

/// 사용자 계정의 로그인 또는 회원가입 결과를 나타내는 열거형.
enum MSIAuthStatus {
  success,
  alreadyLoggedIn,
  emailAlreadyInUse,
  invalidEmail,
  invalidUser,
  requiresRecentLogin,
  unknownError,
  userNotFound,
  weakPassword,
  wrongPassword
}

/// 사용자의 계정 정보를 나타내는 클래스.
class MSIUser {
  final CollectionReference _users = _firestore.collection("users");
  
  String? uid, name, email, password, phoneNumber;
  String? profession, interest, resume, avatarUrl, baseName;

  List<dynamic>? msiList, mhiList;

  MSIUser({
    this.uid,
    this.name,
    this.email,
    this.password,
    this.phoneNumber,
    this.profession,
    this.interest,
    this.resume,
    this.avatarUrl,
    this.baseName,
    this.msiList,
    this.mhiList
  });

  /// 사용자 정보를 초기화한다.
  static Future<MSIUser> init({String? uid}) async {
    if (uid == null && _auth.currentUser == null) {
      throw Exception("고유 ID가 null 값인 사용자는 초기화할 수 없습니다.");
    }

    MSIUser result = MSIUser(uid: uid ?? _auth.currentUser!.uid);

    await result._init();

    return result;
  }

  /// 사용자 계정에 로그인한다.
  Future<MSIAuthStatus> login() async {
    try {
      UserCredential _ = await _auth.signInWithEmailAndPassword(
        email: email!, 
        password: password!
      );

      await _init();
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        return MSIAuthStatus.invalidEmail;
      } else if (e.code == "user-not-found") {
        return MSIAuthStatus.userNotFound;
      } else if (e.code == "wrong-password") {
        return MSIAuthStatus.wrongPassword;
      }
    } catch (e) {
      return MSIAuthStatus.unknownError;
    }

    return MSIAuthStatus.success;
  }

  /// 사용자 계정에서 로그아웃한다.
  Future<MSIAuthStatus> logout() async {
    if (_auth.currentUser == null) {
      return MSIAuthStatus.invalidUser;
    }

    await _auth.signOut();

    return MSIAuthStatus.success;
  }

  /// 이메일과 비밀번호로 회원가입을 진행한다.
  Future<MSIAuthStatus> signUp() async {
    try {
      if (uid != null) {
        return MSIAuthStatus.alreadyLoggedIn;
      }

      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email!, 
        password: password!
      );

      uid = credential.user!.uid;

      await _users.doc(uid).set({
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "profession": profession,
        "interest": interest,
        "resume": "(없음)",
        "avatarUrl": null,
        "baseName": null,
        "msiList": [],
        "mhiList": [],
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return MSIAuthStatus.emailAlreadyInUse;
      } else if (e.code == "invalid-email") {
        return MSIAuthStatus.invalidEmail;
      } else if (e.code == "weak-password") {
        return MSIAuthStatus.weakPassword;
      }
    } catch (e) {
      return MSIAuthStatus.unknownError;
    }

    return MSIAuthStatus.success;
  }

  /// 사용자 계정의 비밀번호를 변경한다.
  Future<MSIAuthStatus> changePassword({
    required String oldPassword, 
    required String newPassword
  }) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email ?? "", 
        password: oldPassword
      );

      await credential.user!.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        return MSIAuthStatus.invalidEmail;
      } else if (e.code == "requires-recent-login") {    
        return MSIAuthStatus.requiresRecentLogin;
      } else if (e.code == "user-not-found") {
        return MSIAuthStatus.userNotFound;
      } else if (e.code == "weak-password") {
        return MSIAuthStatus.weakPassword;
      } else if (e.code == "wrong-password") {
        return MSIAuthStatus.wrongPassword;
      }
    } catch (e) {
      return MSIAuthStatus.unknownError;
    }

    return MSIAuthStatus.success;
  }

  /// 서버에 저장된 사용자 정보를 업데이트한다.
  Future<MSIAuthStatus> update() async {
    await _users.doc(uid).update({
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "profession": profession,
      "interest": interest,
      "resume": resume,
      "avatarUrl": avatarUrl,
      "baseName": baseName,
      "msiList": msiList ?? [],
      "mhiList": mhiList ?? [],
    });

    return MSIAuthStatus.success;
  }

  /// 사용자 계정을 삭제한다.
  Future<MSIAuthStatus> delete() async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email!, 
        password: password!
      );

      await credential.user!.delete();
      await _users.doc(credential.user!.uid).delete();
    } on FirebaseAuthException catch (e) {
       if (e.code == "requires-recent-login") {    
        return MSIAuthStatus.requiresRecentLogin;
      }
    } catch (e) {
      return MSIAuthStatus.unknownError;
    }

    return MSIAuthStatus.success;
  }

  // 사용자 클래스를 `types.User` 형태로 변환한다.
  types.User toChatUser() {
    return types.User(
      id: "$uid",
      firstName: "$name",
      lastName: "($baseName)",
      imageUrl: "$avatarUrl"
    );
  }

  /// 사용자 정보를 서버에서 불러온다.
  Future<void> _init() async {
    DocumentSnapshot snapshot = await _users.doc(uid).get();

    if (snapshot.exists) {
      name = snapshot["name"];
      email = snapshot["email"];
      phoneNumber = snapshot["phoneNumber"];
      profession = snapshot["profession"];
      interest = snapshot["interest"];
      resume = snapshot["resume"];
      avatarUrl = snapshot["avatarUrl"];
      baseName = snapshot["baseName"];
      msiList = snapshot["msiList"] ?? [];
      mhiList = snapshot["mhiList"] ?? [];
    }
  }
}
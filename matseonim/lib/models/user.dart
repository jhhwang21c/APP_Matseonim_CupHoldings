import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

/// 사용자 계정의 로그인 또는 회원가입 결과를 나타내는 열거형.
enum AuthStatus {
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

  List<dynamic>? msiList, mhiList, reqList;

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
    this.mhiList,
    this.reqList
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
  Future<AuthStatus> login() async {
    try {
      UserCredential _ = await _auth.signInWithEmailAndPassword(
        email: email!, 
        password: password!
      );

      await _init();
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        return AuthStatus.invalidEmail;
      } else if (e.code == "user-not-found") {
        return AuthStatus.userNotFound;
      } else if (e.code == "wrong-password") {
        return AuthStatus.wrongPassword;
      }
    } catch (e) {
      return AuthStatus.unknownError;
    }

    return AuthStatus.success;
  }

  /// 사용자 계정에서 로그아웃한다.
  Future<AuthStatus> logout() async {
    if (_auth.currentUser == null) {
      return AuthStatus.invalidUser;
    }

    await _auth.signOut();

    return AuthStatus.success;
  }

  /// 이메일과 비밀번호로 회원가입을 진행한다.
  Future<AuthStatus> signUp() async {
    try {
      if (uid != null) {
        return AuthStatus.alreadyLoggedIn;
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
        "resume": "",
        "avatarUrl": null,
        "baseName": null,
        "msiList": [],
        "mhiList": [],
        "reqList": []
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return AuthStatus.emailAlreadyInUse;
      } else if (e.code == "invalid-email") {
        return AuthStatus.invalidEmail;
      } else if (e.code == "weak-password") {
        return AuthStatus.weakPassword;
      }
    } catch (e) {
      return AuthStatus.unknownError;
    }

    return AuthStatus.success;
  }

  /// 사용자 계정의 비밀번호를 변경한다.
  Future<AuthStatus> changePassword({
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
    } catch (e) {
      return AuthStatus.unknownError;
    }

    return AuthStatus.success;
  }

  /// 사용자의 맞선임 목록에 주어진 고유 ID를 가진 사용자를 추가한다.
  Future<void> addMatseonim({required String msiUid}) async {
    MSIUser msi = await MSIUser.init(uid: msiUid);

    msiList!.add(msiUid);
    await update();

    msi.mhiList!.add(uid!);
    await msi.update();
  }

  /// 사용자의 맞선임 목록에서 주어진 고유 ID를 가진 사용자를 제거한다.
  Future<void> removeMatseonim({required String msiUid}) async {
    MSIUser msi = await MSIUser.init(uid: msiUid);

    msiList!.remove(msiUid);
    await update();

    msi.mhiList!.remove(uid!);
    await msi.update();
  }

  /// 서버에 저장된 사용자 정보를 업데이트한다.
  Future<AuthStatus> update() async {
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
      "reqList": reqList ?? []
    });

    return AuthStatus.success;
  }

  /// 사용자 계정을 삭제한다.
  Future<AuthStatus> delete() async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email!, 
        password: password!
      );

      await credential.user!.delete();
      await _users.doc(credential.user!.uid).delete();
    } on FirebaseAuthException catch (e) {
       if (e.code == "requires-recent-login") {    
        return AuthStatus.requiresRecentLogin;
      }
    } catch (e) {
      return AuthStatus.unknownError;
    }

    return AuthStatus.success;
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
      reqList = snapshot["reqList"] ?? [];
    }
  }
}
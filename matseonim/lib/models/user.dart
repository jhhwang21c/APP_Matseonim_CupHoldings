import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:matseonim/models/request.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

/// 사용자 계정 관련 작업의 결과를 나타내는 열거형.
enum MSIUserStatus {
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

  Map<String, dynamic>? votes;

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
  Future<MSIUserStatus> login() async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email!, 
        password: password!
      );

      uid = credential.user!.uid;

      await _init();
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        return MSIUserStatus.invalidEmail;
      } else if (e.code == "user-not-found") {
        return MSIUserStatus.userNotFound;
      } else if (e.code == "wrong-password") {
        return MSIUserStatus.wrongPassword;
      }
    } catch (e) {
      return MSIUserStatus.unknownError;
    }

    return MSIUserStatus.success;
  }

  /// 사용자 계정에서 로그아웃한다.
  Future<MSIUserStatus> logout() async {
    if (_auth.currentUser == null) {
      return MSIUserStatus.invalidUser;
    }

    await _auth.signOut();

    return MSIUserStatus.success;
  }

  /// 이메일과 비밀번호로 회원가입을 진행한다.
  Future<MSIUserStatus> signUp() async {
    try {
      if (uid != null) {
        return MSIUserStatus.alreadyLoggedIn;
      }

      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email!, 
        password: password!
      );

      uid = credential.user!.uid;

      await _users.doc(uid!).set({
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
        "votes": []
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return MSIUserStatus.emailAlreadyInUse;
      } else if (e.code == "invalid-email") {
        return MSIUserStatus.invalidEmail;
      } else if (e.code == "weak-password") {
        return MSIUserStatus.weakPassword;
      }
    } catch (e) {
      return MSIUserStatus.unknownError;
    }

    return MSIUserStatus.success;
  }

  /// 사용자 계정의 비밀번호를 변경한다.
  Future<MSIUserStatus> changePassword({
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
        return MSIUserStatus.invalidEmail;
      } else if (e.code == "requires-recent-login") {    
        return MSIUserStatus.requiresRecentLogin;
      } else if (e.code == "user-not-found") {
        return MSIUserStatus.userNotFound;
      } else if (e.code == "weak-password") {
        return MSIUserStatus.weakPassword;
      } else if (e.code == "wrong-password") {
        return MSIUserStatus.wrongPassword;
      }
    } catch (e) {
      return MSIUserStatus.unknownError;
    }

    return MSIUserStatus.success;
  }

  /// 다른 사용자의 의뢰 요청을 수락한다.
  Future<MSIUserStatus> acceptRequest({required MSIRequest request}) async {
    if (uid == null) {
      return MSIUserStatus.invalidUser;
    }

    MSIUser mhi = MSIUser(uid: request.uid);

    if (mhiList != null && !mhiList!.contains(request.uid)) {
      mhiList!.add(request.uid);
      await update();
    }

    if (mhi.msiList != null && !mhi.msiList!.contains(uid)) {
      mhi.msiList!.add(uid);
      await mhi.update();
    }

    return MSIUserStatus.success;
  }

  /// 사용자의 평균 평점을 반환한다.
  double getAverageRating() {
    if (votes == null || votes!.isEmpty) {
      return 0.0;
    }

    double result = 0.0;

    for (double value in votes!.values) {
      result += value;
    }

    return result / (votes!.length);
  }

  /// 사용자의 평점 데이터에 새로운 평점을 추가한다.
  Future<MSIUserStatus> vote({required MSIUser voter, required double rating}) async {
    if (uid == null || voter.uid == null) {
      return MSIUserStatus.invalidUser;
    } else if (uid == voter.uid) {
      return MSIUserStatus.unknownError;
    }

    votes = votes ?? {};
    votes![voter.uid!] = rating;

    await _users.doc(uid!).update({
      "votes": votes
    });

    return MSIUserStatus.success;
  }

  /// 사용자 정보를 서버에서 다시 불러온다.
  Future<void> reload() async {
    await _init();
  }

  /// 서버에 저장된 사용자 정보를 업데이트한다.
  Future<MSIUserStatus> update() async {
    if (uid == null) {
      return MSIUserStatus.invalidUser;
    } 

    await _users.doc(uid!).update({
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
      "votes": votes ?? {}
    });

    return MSIUserStatus.success;
  }

  /// 사용자 계정을 삭제한다.
  Future<MSIUserStatus> delete() async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email!, 
        password: password!
      );

      await credential.user!.delete();
      await _users.doc(credential.user!.uid).delete();
    } on FirebaseAuthException catch (e) {
       if (e.code == "requires-recent-login") {    
        return MSIUserStatus.requiresRecentLogin;
      }
    } catch (e) {
      return MSIUserStatus.unknownError;
    }

    return MSIUserStatus.success;
  }

  /// 사용자 정보를 서버에서 불러온다.
  Future<void> _init() async {
    DocumentSnapshot snapshot = await _users.doc(uid!).get();

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
      votes = snapshot["votes"] ?? [];
    }
  }
}
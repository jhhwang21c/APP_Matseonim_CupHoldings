import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/custom_alert_dialog.dart';

typedef _RouteCallback = void Function();

class MSIUser {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String email, password;

  String? name, phoneNumber, profession, interest;
  String? avatarUrl, baseName;

  MSIUser(
      {required this.email,
      required this.password,
      this.name,
      this.phoneNumber,
      this.profession,
      this.interest,
      this.avatarUrl,
      this.baseName});

  void signIn(_RouteCallback routeCallback) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      routeCallback();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.dialog(const CustomAlertDialog(message: "사용자를 찾을 수 없습니다."));
      } else if (e.code == 'wrong-password') {
        Get.dialog(const CustomAlertDialog(message: "비밀번호가 틀렸습니다."));
      }
    }
  }

  void signUp(_RouteCallback routeCallback) async {
    CollectionReference users = _firestore.collection('users');

    try {
      users.add({
        "name": name,
        "phoneNumber": phoneNumber,
        "email": email,
        "profession": profession,
        "interest": interest,
        "avatar_url": null,
        "base_name": null
      }).catchError((error) =>
          throw FirebaseException(plugin: "cloud_firestore", message: error));

      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      routeCallback();
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        Get.dialog(const CustomAlertDialog(message: "이미 사용 중인 이메일 주소입니다."));
      } else if (e.code == "invalid-email") {
        Get.dialog(const CustomAlertDialog(message: "올바르지 않은 이메일 주소입니다."));
      }
    } on FirebaseException catch (_) {
      Get.dialog(const CustomAlertDialog(message: "알 수 없는 오류가 발생하였습니다."));
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/custom_alert_dialog.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class MSIUser {
  String? email, password;
  String? name, phoneNumber, profession, interest;
  String? avatarUrl, baseName;

  MSIUser({
    this.name,
    this.email,
    this.password,
    this.phoneNumber,
    this.profession,
    this.interest,
    this.avatarUrl,
    this.baseName
  }) {
    reload();
  }

  Future<void> delete({void Function()? onComplete}) async {
    if (_auth.currentUser == null) return;

    String uid = _auth.currentUser!.uid;

    await _auth.currentUser!.delete();

    CollectionReference users = _firestore.collection("users");

    users.doc(uid).delete().then((_) => onComplete?.call());
  }

  Future<void> login({void Function()? onComplete}) async {
    if (email == null || password == null) return;
  
    try {
      UserCredential _ = await _auth.signInWithEmailAndPassword(
        email: email!, 
        password: password!
      );

      reload().then((_) => onComplete?.call());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.dialog(const CustomAlertDialog(message: "사용자를 찾을 수 없습니다."));
      } else if (e.code == 'wrong-password') {
        Get.dialog(const CustomAlertDialog(message: "비밀번호가 틀렸습니다."));
      }
    }
  }

  Future<void> logout({void Function()? onComplete}) async {
    if (_auth.currentUser == null) return;

    _auth.signOut().then((_) => onComplete?.call());
  }

  Future<void> reload({void Function()? onComplete}) async {
    if (_auth.currentUser == null) return;

    CollectionReference users = _firestore.collection("users");

    users.doc(_auth.currentUser!.uid).get().then(
      (DocumentSnapshot documentSnapshot) {
        if (!documentSnapshot.exists) {
          documentSnapshot.reference.set({
            "name": name,
            "email": email,
            "phoneNumber": phoneNumber,
            "profession": profession,
            "interest": interest,
            "avatarUrl": null,
            "baseName": null
          });
        }

        Map<String, dynamic> values = documentSnapshot.data() as Map<String, dynamic>;

        name = values["name"];
        email = values["email"];
        phoneNumber = values["phoneNumber"];
        profession = values["profession"];
        interest = values["interest"];
        avatarUrl = values["avatarUrl"];
        baseName = values["baseName"];

        onComplete?.call();
      }
    );
  }

  Future<void> signUp({void Function()? onComplete}) async {
    if (email == null || password == null) return;

    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email!, 
        password: password!
      );

      CollectionReference users = _firestore.collection("users");

      users.doc(credential.user?.uid).set({
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "profession": profession,
        "interest": interest,
        "avatarUrl": null,
        "baseName": null
      }).then((_) => onComplete?.call());
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

  Future<void> update({void Function()? onComplete}) async {
    CollectionReference users = _firestore.collection("users");

    users.doc(_auth.currentUser?.uid).update({
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "profession": profession,
      "interest": interest,
      "avatarUrl": avatarUrl,
      "baseName": baseName
    }).then((_) => onComplete?.call());
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus {
  success,
  emailAlreadyInUse,
  invalidEmail,
  unknownError,
  userNotFound,
  weakPassword,
  wrongPassword
}

class MSIUser {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? uid, name, email, password;
  String? phoneNumber, profession, interest;
  String? avatarUrl, baseName;

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
  }) {
    _init();
  }

  Future<void> delete() async {
    _auth.currentUser?.delete().then(
      (_) {
        CollectionReference users = _firestore.collection("users");
        users.doc(uid ?? _auth.currentUser?.uid).delete();
      }
    );
  }

  Future<AuthStatus> login() async {
    try {
      UserCredential _ = await _auth.signInWithEmailAndPassword(
        email: email ?? "", 
        password: password ?? ""
      );

      _init();

      return AuthStatus.success;
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        return AuthStatus.invalidEmail;
      } else if (e.code == 'user-not-found') {
        return AuthStatus.userNotFound;
      } else if (e.code == 'wrong-password') {
        return AuthStatus.wrongPassword;
      }
    }

    return AuthStatus.unknownError;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<AuthStatus> signUp() async {
    try {
      _auth.createUserWithEmailAndPassword(
        email: email ?? "", 
        password: password ?? ""
      ).then((_) => _init());
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

  Future<void> update() async {
    CollectionReference users = _firestore.collection("users");

    await users.doc(uid ?? _auth.currentUser?.uid).update({
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "profession": profession,
      "interest": interest,
      "avatarUrl": avatarUrl,
      "baseName": baseName
    });
  }

  Future<void> _init() async {
    if (uid == null && _auth.currentUser == null) return;

    CollectionReference users = _firestore.collection("users");

    await _initFromDocument(await users.doc(uid ?? _auth.currentUser!.uid).get());
  }

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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

    UserCredential _ = await _auth.signInWithEmailAndPassword(
      email: email!, 
      password: password!
    );

    reload().then((_) => onComplete?.call());
  }

  Future<void> logout({void Function()? onComplete}) async {
    if (_auth.currentUser == null) return;

    _auth.signOut().then((_) => onComplete?.call());
  }

  Future<void> reload({void Function()? onComplete}) async {
    if (_auth.currentUser == null) return;

    CollectionReference users = _firestore.collection("users");

    users.doc(_auth.currentUser!.uid).get().then(
      (DocumentSnapshot value) {
        name = value["name"];
        phoneNumber = value["phoneNumber"];
        profession = value["profession"];
        interest = value["interest"];
        avatarUrl = value["avatarUrl"];
        baseName = value["baseName"];

        onComplete?.call();
      }
    );
  }

  Future<void> signUp({void Function()? onComplete}) async {
    if (email == null || password == null) return;

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
      "avatar_url": null,
      "base_name": null
    }).then((_) => onComplete?.call());
  }

  Future<void> update({void Function()? onComplete}) async {
    CollectionReference users = _firestore.collection("users");

    users.doc(_auth.currentUser?.uid).update({
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "profession": profession,
      "interest": interest,
      "avatar_url": avatarUrl,
      "base_name": baseName
    }).then((_) => onComplete?.call());
  }
}

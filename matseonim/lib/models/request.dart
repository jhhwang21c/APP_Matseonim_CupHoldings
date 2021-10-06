import 'package:cloud_firestore/cloud_firestore.dart';  

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

enum RequestStatus {
  success,
  unknownError 
}

class MSIRequest {
  String requestId, uid, interest;
  String title, description;

  MSIRequest({
    required this.requestId,
    required this.uid,
    required this.interest,
    required this.title,
    required this.description
  });
}

class MSIRequests {
  static Future<void> add({
    required String uid,
    required String interest,
    required String title,
    required String description
  }) async {
    CollectionReference requests = _firestore.collection("requests");

    await requests.add({
      "uid": uid,
      "interest": interest,
      "title": title,
      "description": description
    });
  }

  static Future<MSIRequest> get({required String requestId}) async {
    CollectionReference requests = _firestore.collection("requests");

    DocumentSnapshot document = await requests.doc(requestId).get(); 

    return MSIRequest(
      requestId: requestId,
      uid: document["uid"],
      interest: document["interest"],
      title: document["title"],
      description: document["description"]
    );
  }

  static Future<List<MSIRequest>> getAll({required String uid}) async {
    List<MSIRequest> result = [];

    QuerySnapshot query = await _firestore.collection("requests")
      .where("uid", isEqualTo: uid)
      .get();

    for (QueryDocumentSnapshot document in query.docs) {
      result.add(
        MSIRequest(
          requestId: document.id,
          uid: document["uid"],
          interest: document["interest"],
          title: document["title"],
          description: document["description"]
        )
      );
    }

    return result;
  }

  static Future<void> delete({required String requestId}) async {
    CollectionReference requests = _firestore.collection("requests");

    await requests.doc(requestId).delete();
  }

  static Future<void> deleteAll({required String uid}) async {
    CollectionReference requests = _firestore.collection("requests");

    QuerySnapshot query = await _firestore.collection("requests")
      .where("uid", isEqualTo: uid)
      .get();

    for (QueryDocumentSnapshot document in query.docs) {
      await document.reference.delete();
    }
  }
}
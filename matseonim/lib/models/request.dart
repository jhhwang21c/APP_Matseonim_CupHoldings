import 'package:cloud_firestore/cloud_firestore.dart';  

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

/// 사용자가 보낸 의뢰 요청을 나타내는 클래스.
class MSIRequest {
  String requestId, uid, field;
  String title, description;

  MSIRequest({
    required this.requestId,
    required this.uid,
    required this.field,
    required this.title,
    required this.description
  });
}

/// 사용자의 의뢰 요청을 관리하는 클래스.
class MSIRequests {
  /// 새로운 의뢰를 생성한다.
  static Future<void> add({
    required String uid,
    required String field,
    required String title,
    required String description
  }) async {
    CollectionReference requests = _firestore.collection("requests");

    await requests.add({
      "uid": uid,
      "field": field,
      "title": title,
      "description": description
    });
  }

  /// 의뢰의 고유 ID를 통해 의뢰 내용을 서버에서 불러온다.
  static Future<MSIRequest> get({required String requestId}) async {
    CollectionReference requests = _firestore.collection("requests");

    DocumentSnapshot document = await requests.doc(requestId).get(); 

    return MSIRequest(
      requestId: requestId,
      uid: document["uid"],
      field: document["field"],
      title: document["title"],
      description: document["description"]
    );
  }

  /// 주어진 전문 분야와 연관된 모든 의뢰를 서버에서 불러온다.
  static Future<List<MSIRequest>> getIncoming({required String profession}) async {
    List<MSIRequest> result = [];

    QuerySnapshot query = await _firestore.collection("requests")
      .where("profession", isEqualTo: profession)
      .get();

    for (QueryDocumentSnapshot document in query.docs) {
      result.add(
        MSIRequest(
          requestId: document.id,
          uid: document["uid"],
          field: document["field"],
          title: document["title"],
          description: document["description"]
        )
      );
    }

    return result;
  }

  /// 주어진 고유 ID를 가진 사용자가 생성한 모든 의뢰를 서버에서 불러온다.
  static Future<List<MSIRequest>> getOutgoing({required String uid}) async {
    List<MSIRequest> result = [];

    CollectionReference requests = _firestore.collection("requests");

    QuerySnapshot query = await requests.where("uid", isEqualTo: uid).get();

    for (QueryDocumentSnapshot document in query.docs) {
      result.add(
        MSIRequest(
          requestId: document.id,
          uid: document["uid"],
          field: document["field"],
          title: document["title"],
          description: document["description"]
        )
      );
    }

    return result;
  }

  /// 주어진 고유 ID를 가진 의뢰를 서버에서 삭제한다.
  static Future<void> delete({required String requestId}) async {
    CollectionReference requests = _firestore.collection("requests");

    await requests.doc(requestId).delete();
  }

  /// 주어진 고유 ID를 가진 사용자의 모든 의뢰를 서버에서 삭제한다.
  static Future<void> deleteAll({required String uid}) async {
    CollectionReference requests = _firestore.collection("requests");

    QuerySnapshot query = await requests.where("uid", isEqualTo: uid).get();

    for (QueryDocumentSnapshot document in query.docs) {
      await document.reference.delete();
    }
  }
}
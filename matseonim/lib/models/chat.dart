import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:matseonim/models/user.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

/// 메시지를 나타내는 클래스.
class MSIMessage {
  String? messageId, roomId, createdAt, updatedAt, text;

  MSIMessage({
    this.messageId,
    this.roomId,
    this.createdAt,
    this.updatedAt,
    this.text
  });
}

/// 채팅방을 나타내는 클래스.
class MSIRoom {
  final CollectionReference _rooms = _firestore.collection("rooms");

  List<MSIUser> users;

  String? roomId, createdAt, updatedAt;

  MSIRoom({
    required this.users,
    this.roomId,
    this.createdAt,
    this.updatedAt
  });

  /// 채팅방을 초기화한다.
  static Future<MSIRoom> init({
    required List<MSIUser> users,
  }) async {
    if (users.isEmpty || users.length != 2) {
      throw Exception("채팅방을 초기화하려면 총 2명의 사용자가 필요합니다.");
    } else if (users[0].uid == null || users[1].uid == null) {
      throw Exception("고유 ID가 null 값인 사용자는 채팅에 참여할 수 없습니다.");
    }

    MSIRoom result = MSIRoom(users: users);

    await result._init();

    return result;
  }

  /// 채팅방의 모든 메시지를 반환한다. 
  Stream<List<MSIMessage>> getMessages() {
    /* TODO: ... */
    
    throw UnimplementedError();
  }

  /// 채팅방에 메시지를 전송한다.
  Future<void> sendMessage() async {
    /* TODO: ... */

    throw UnimplementedError();
  }

  /// 채팅방의 메시지를 수정한다.
  Future<void> updateMessage() async {
    /* TODO: ... */

    throw UnimplementedError();
  }

  /// 채팅방 정보를 서버에서 불러온다.
  Future<void> _init() async {
    QuerySnapshot query = await _rooms
      .where("users", arrayContains: users[0].uid)
      .where("users", arrayContains: users[1].uid)
      .get();

    if (query.size > 0) {
      QueryDocumentSnapshot snapshot = query.docs[0];

      createdAt = snapshot["createdAt"];
      updatedAt = snapshot["updatedAt"];
    } else {
      int currentTime = Timestamp.now()
        .millisecondsSinceEpoch;

      DocumentReference reference = await _rooms.add({
        "users": users,
        "createdAt": currentTime,
        "updatedAt": currentTime
      });

      roomId = reference.id;
    }
  }
}
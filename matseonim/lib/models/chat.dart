import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:matseonim/models/user.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

/// 메시지를 나타내는 클래스.
class MSIMessage {
  String messageId, roomId;

  String? text;
  int? createdAt, updatedAt;

  MSIMessage({
    required this.messageId,
    required this.roomId,
    this.createdAt,
    this.updatedAt,
    this.text
  });
}

/// 채팅방을 나타내는 클래스.
class MSIRoom {
  final CollectionReference _rooms = _firestore.collection("rooms");

  List<MSIUser> users;

  String? roomId;
  int? createdAt, updatedAt;

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

  /// 채팅방을 삭제한다.
  Future<void> deleteRoom() async {
    if (roomId == null) {
      throw Exception("고유 ID가 null 값인 채팅방은 삭제할 수 없습니다.");
    }

    await _rooms.doc(roomId).delete();

    roomId = null;
    createdAt = null;
    updatedAt = null;
  }

  /// 채팅방의 메시지를 삭제한다.
  Future<void> deleteMessage(MSIMessage message) async {
    if (roomId == null) {
      throw Exception("고유 ID가 null 값인 채팅방의 메시지는 삭제할 수 없습니다.");
    } else if (roomId != message.roomId) {
      throw Exception(
        "메시지를 삭제하려면 현재 채팅방의 고유 ID와 " 
        "메시지의 채팅방 고유 ID가 같아야 합니다."
      );
    }

    await _rooms.doc(roomId)
      .collection("messages")
      .doc(message.messageId)
      .delete();
  }

  /// 채팅방의 모든 메시지를 반환한다. 
  Stream<List<MSIMessage>> getMessages() {
    if (roomId == null) {
      throw Exception("고유 ID가 null 값인 채팅방의 메시지는 불러올 수 없습니다.");
    }

    return _rooms.doc(roomId)
      .collection("messages")
      .snapshots()
      .map(
        (QuerySnapshot snapshot) {
          return snapshot.docs.fold(
            [], 
            (List<MSIMessage> previousValues, QueryDocumentSnapshot element) {
              MSIMessage message = MSIMessage(
                messageId: element.id,
                roomId: element["roomId"],
                createdAt: element["createdAt"],
                updatedAt: element["updatedAt"],
                text: element["text"]
              );

              return [...previousValues, message];
            }
          );
        }
      );
  }

  /// 채팅방에 메시지를 전송한다.
  Future<void> sendMessage(String text) async {
    if (roomId == null) {
      throw Exception("고유 ID가 null 값인 채팅방에 메시지를 보낼 수 없습니다.");
    }

    await _rooms.doc(roomId)
      .collection("messages")
      .add({
        "createdAt": _getCurrentTime(),
        "updatedAt": _getCurrentTime(),
        "text": text
      });
  }

  /// 채팅방의 메시지를 수정한다.
  Future<void> updateMessage(MSIMessage message) async {
    if (roomId == null) {
      throw Exception("고유 ID가 null 값인 채팅방의 메시지는 수정할 수 없습니다.");
    } else if (roomId != message.roomId) {
      throw Exception(
        "메시지를 수정하려면 현재 채팅방의 고유 ID와 " 
        "메시지의 채팅방 고유 ID가 같아야 합니다."
      );
    }

    await _rooms.doc(roomId)
      .collection("messages")
      .doc(message.messageId)
      .update({
        "updatedAt": _getCurrentTime(),
        "text": message.text
      });
  }

  /// 현재 시간을 밀리초 단위로 반환한다.
  int _getCurrentTime() {
    return Timestamp.now().millisecondsSinceEpoch;
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
      DocumentReference reference = await _rooms.add({
        "users": users,
        "createdAt": _getCurrentTime(),
        "updatedAt": _getCurrentTime()
      });

      roomId = reference.id;
    }
  }
}
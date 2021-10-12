import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:matseonim/models/user.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
    required List<MSIUser> users
  }) async {
    if (users.isEmpty || users.length != 2) {
      throw Exception("채팅방을 초기화하려면 총 2명의 사용자가 필요합니다.");
    }

    MSIRoom result = MSIRoom(users: users);

    await result._init();

    return result;
  }

  /// 채팅방에 메시지를 전송한다.
  Future<void> sendMessage({required MSIUser user, required types.PartialText message}) async {
    if (roomId == null) {
      throw Exception("고유 ID가 null 값인 채팅방에 메시지를 보낼 수 없습니다.");
    } else if (user.uid != users[0].uid && user.uid != users[1].uid) {
      throw Exception("주어진 고유 ID를 가진 사용자를 찾을 수 없습니다.");
    }

    await _rooms.doc(roomId)
      .collection("messages")
      .add({
        "author": {
          "id": user.uid,
          "firstName": user.name,
          "lastName": "(${user.baseName})",
          "imageUrl": user.avatarUrl
        },
        "createdAt": _getCurrentTime(),
        "updatedAt": _getCurrentTime(),
        "status": types.Status.sent.index,
        "text": message.text,
      });
  }

  /// 채팅방의 모든 메시지를 실시간으로 반환한다. 
  Stream<List<types.TextMessage>> getMessages() {
    if (roomId == null) {
      throw Exception("고유 ID가 null 값인 채팅방의 메시지는 불러올 수 없습니다.");
    }

    /// 메시지를 보낸 시간을 기준으로 정렬한다.
    return _rooms.doc(roomId)
      .collection("messages")
      .orderBy("createdAt", descending: true)
      .snapshots()
      .map(
        (QuerySnapshot snapshot) {
          for (var element in snapshot.docs) {
            element.reference.update({
              "status": types.Status.seen.index
            });
          }

          return snapshot.docs.fold(
            [], 
            (List<types.TextMessage> previousValues, QueryDocumentSnapshot element) {
              types.TextMessage message = types.TextMessage(
                author: types.User.fromJson(element["author"]),
                id: element.id,
                text: element["text"],
                roomId: roomId,
                status: types.Status.values[element["status"]],
                createdAt: element["createdAt"],
                updatedAt: element["updatedAt"],
              );

              return [...previousValues, message];
            }
          );
        }
      );
  }

  /// 채팅방의 메시지를 수정한다.
  Future<void> updateMessage(types.TextMessage message) async {
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
      .doc(message.id)
      .update({
        "updatedAt": _getCurrentTime(),
        "text": message.text
      });
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
  Future<void> deleteMessage(types.TextMessage message) async {
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
      .doc(message.id)
      .delete();
  }

  /// 현재 시간을 밀리초 단위로 반환한다.
  int _getCurrentTime() {
    return Timestamp.now().millisecondsSinceEpoch;
  }

  /// 채팅방 정보를 서버에서 불러온다.
  Future<void> _init() async {
    var snapshots = await _rooms.snapshots()
      .map(
        (QuerySnapshot snapshot) {
          return snapshot.docs.where(
            (QueryDocumentSnapshot snapshot) {
              List<dynamic> value = snapshot["users"];

              return value.contains(users[0].uid) && value.contains(users[1].uid);
            }
          );
        }
      ).first;

    List<QueryDocumentSnapshot> queryList = snapshots.toList();

    if (queryList.isNotEmpty) {
      QueryDocumentSnapshot snapshot = queryList[0];

      users = (snapshot["users"] as List<dynamic>)
        .map((uid) => MSIUser(uid: uid))
        .toList();

      for (MSIUser user in users) { 
        await user.reload(); 
      }

      createdAt = snapshot["createdAt"];
      updatedAt = snapshot["updatedAt"];

      roomId = snapshot.id;
    } else {
      DocumentReference reference = await _rooms.add({
        "users": [users[0].uid, users[1].uid],
        "createdAt": _getCurrentTime(),
        "updatedAt": _getCurrentTime()
      });

      roomId = reference.id;
    }
  }
}
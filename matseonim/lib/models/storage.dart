import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:matseonim/models/user.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;

/// 사용자의 파일 업로드 또는 다운로드 결과를 나타내는 열거형.
enum StorageStatus {
  canceled,
  permissionDenied,
  success,
  unknownError
}

/// 사용자의 파일 업로드와 다운로드를 관리하는 클래스.
class MSIStorage {
  /// 사용자의 프로필 사진을 서버에 업로드한다.
  static Future<StorageStatus> pickAvatar({required MSIUser user}) async {
    final ImagePicker _picker = ImagePicker();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      try {
        await _storage.ref("avatars/${user.uid}.png").putData(await image.readAsBytes());

        // CORS 구성 필요 (https://firebase.google.com/docs/storage/web/download-files)
        user.avatarUrl = await _storage.ref("avatars/${user.uid}.png")
          .getDownloadURL();

        await user.update();

        return StorageStatus.success;
      } on FirebaseException catch (e) {
        if (e.code == "canceled") {
          return StorageStatus.canceled;
        } else if (e.code == "permission-denied") {
          return StorageStatus.permissionDenied;
        } else {
          return StorageStatus.unknownError;
        }
      }
    } else {
      return StorageStatus.unknownError;
    }
  }
}
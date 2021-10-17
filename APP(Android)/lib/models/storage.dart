import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:matseonim/models/user.dart';

const int maxFileSize = 2 * 1024 * 1024;

final FirebaseStorage _storage = FirebaseStorage.instance;

/// 사용자의 파일 업로드 또는 다운로드 결과를 나타내는 열거형.
enum MSIStorageStatus {
  success,
  canceled,
  fileTooLarge,
  permissionDenied,
  unknownError
}

/// 사용자의 파일 업로드와 다운로드를 관리하는 클래스.
class MSIStorage {
  /// 사용자의 프로필 사진을 서버에 업로드한다.
  static Future<MSIStorageStatus> pickAvatar({required MSIUser user}) async {
    final ImagePicker _picker = ImagePicker();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return MSIStorageStatus.unknownError;
    }

    try {
      Uint8List imageData = await image.readAsBytes();

      if (imageData.lengthInBytes > maxFileSize) {
        return MSIStorageStatus.fileTooLarge;
      }

      await _storage.ref("avatars/${user.uid}.png").putData(imageData);

      // @jdeokkim: CORS 구성 필요 (https://firebase.google.com/docs/storage/web/download-files)
      user.avatarUrl = await _storage.ref("avatars/${user.uid}.png")
        .getDownloadURL();

      await user.update();

      return MSIStorageStatus.success;
    } on FirebaseException catch (e) {
      // TODO: ...
      Get.snackbar("오류", e.toString());

      if (e.code == "canceled") {
        return MSIStorageStatus.canceled;
      } else if (e.code == "permission-denied") {
        return MSIStorageStatus.permissionDenied;
      } else {
        return MSIStorageStatus.unknownError;
      }
    }
  }
}
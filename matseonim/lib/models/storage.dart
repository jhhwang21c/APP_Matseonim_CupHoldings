import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:matseonim/models/user.dart';

enum StorageStatus {
  canceled,
  permissionDenied,
  success,
  unknownError
}

class MSIStorage {
  static Future<StorageStatus> pickAvatar({required MSIUser user}) async {
    final FirebaseStorage _storage = FirebaseStorage.instance;
    final ImagePicker _picker = ImagePicker();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      try {
        await _storage.ref("avatars/${user.uid}.png").putData(await image.readAsBytes());

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
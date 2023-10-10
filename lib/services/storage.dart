import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  static Future<String> uploadFile(File imageFile) async {
    // Create a reference to the location where you want to upload the image.
    final reference = FirebaseStorage.instance
        .ref()
        .child('/${imageFile.path.split('/').last}');

    // Upload the image.
    final uploadTask = reference.putFile(imageFile);

    // Wait for the upload to complete.
    await uploadTask.whenComplete(() => {});

    // Get the download URL for the uploaded image.
    final downloadUrl = await reference.getDownloadURL();

    return downloadUrl;
  }
}

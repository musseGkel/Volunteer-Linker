import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:volunteer_linker/services/api_reponse.dart';

class ImageDataSource {
  Future<ApiResponse> storeImage(
    File file,
  ) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('images/${file.path.split('/').last}');
      final uploadTask = storageRef.putFile(file);
      final snapshot = await uploadTask.whenComplete(() {
        print('File uploaded');
      });
      final downloadUrl = await snapshot.ref.getDownloadURL();
      print('Download URL: $downloadUrl');
      return ApiResponse(
        statusCode: 200,
        message: "Success",
        body: downloadUrl,
      );
    } catch (e) {
      return ApiResponse(
        statusCode: 400,
        message: "Error",
      );
    }
  }
}

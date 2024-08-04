import 'dart:io';

import 'package:volunteer_linker/services/api_reponse.dart';

abstract class ImageRepository {
  Future<ApiResponse> uploadImageToFirebase(
    File file,
  );
}

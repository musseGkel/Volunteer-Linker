import 'dart:io';

import 'package:volunteer_linker/services/api_reponse.dart';

import '../repository/image_repository.dart';

class StoreImageUsecase {
  final ImageRepository repository;

  StoreImageUsecase(this.repository);

  Future<ApiResponse> call(
    File file,
  ) async {
    return await repository.uploadImageToFirebase(
      file,
    );
  }
}

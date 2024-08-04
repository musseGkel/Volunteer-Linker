import 'dart:io';

import 'package:volunteer_linker/features/image/domain/repository/image_repository.dart';
import 'package:volunteer_linker/services/api_reponse.dart';

import '../datasource/image_datasource.dart';

class ImageRepoImpl extends ImageRepository {
  final ImageDataSource dataSource;

  ImageRepoImpl({required this.dataSource});

  @override
  Future<ApiResponse> uploadImageToFirebase(File file) {
    return dataSource.storeImage(
      file,
    );
  }
}

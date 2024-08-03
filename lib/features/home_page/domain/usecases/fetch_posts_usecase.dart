import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunteer_linker/services/api_reponse.dart';

import '../repository/home_page_repository.dart';

class FetchPostsUseCase {
  final HomePageRepository repository;

  FetchPostsUseCase(this.repository);

  Future<ApiResponse> call({
    DocumentSnapshot<Object?>? startAfter,
    required int limit,
  }) async {
    return await repository.fetchPosts(
      limit: limit,
      startAfter: startAfter,
    );
  }
}

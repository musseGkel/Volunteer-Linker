import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../services/api_reponse.dart';

abstract class HomePageRepository {
  HomePageRepository();

  Future<ApiResponse> fetchPosts({
    DocumentSnapshot<Object?>? startAfter,
    required int limit,
    String? userId,
  });
}

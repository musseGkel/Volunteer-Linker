import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunteer_linker/features/home_page/domain/repository/home_page_repository.dart';
import 'package:volunteer_linker/services/api_reponse.dart';

import '../datasource/home_page_datasource.dart';

class HomePageRepoImpl implements HomePageRepository {
  final HomePageDatasource dataSource;

  HomePageRepoImpl(
    this.dataSource,
  );

  @override
  Future<ApiResponse> fetchPosts({
    DocumentSnapshot<Object?>? startAfter,
    required int limit,
    String? userId,
  }) {
    return dataSource.fetchPosts(
        startAfter: startAfter, limit: limit, userId: userId);
  }
}

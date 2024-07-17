import 'package:volunteer_linker/features/profile/data/datasource/profile_datasource.dart';

import '../../../../core/models/user.dart';
import '../../../../services/api_reponse.dart';
import '../../domain/repository/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  ProfileDatasource datasource;

  ProfileRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<ApiResponse> updateProfile({
    required UserData user,
  }) async {
    return await datasource.updateProfile(user: user);
  }

  @override
  Future<ApiResponse> getProfile({
    required String userId,
  }) async {
    return await datasource.getProfile(userId);
  }
}

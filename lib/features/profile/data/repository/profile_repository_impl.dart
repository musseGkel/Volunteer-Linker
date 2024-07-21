import 'package:volunteer_linker/core/models/organization.dart';
import 'package:volunteer_linker/features/profile/data/datasource/profile_datasource.dart';

import '../../../../core/models/user_data.dart';
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
    return await datasource.updateProfile(
      user: user,
    );
  }

  @override
  Future<ApiResponse> updateOrganizationProfile({
    required Organization organization,
  }) async {
    return await datasource.updateOrganizationProfile(
      organization: organization,
    );
  }

  @override
  Future<ApiResponse> getProfile({
    required String userId,
  }) async {
    return await datasource.getProfile(
      userId,
    );
  }

  @override
  Future<ApiResponse> getOrganizationProfile({
    required String userId,
  }) async {
    return await datasource.getOrganizationProfile(
      userId,
    );
  }

  @override
  Future<ApiResponse> getProfileInfo({
    required String userId,
  }) async {
    return await datasource.getProfileInfo(
      userId,
    );
  }
}

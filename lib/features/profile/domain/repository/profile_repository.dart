import 'package:volunteer_linker/core/models/organization.dart';

import '../../../../services/api_reponse.dart';
import '../../../../core/models/user_data.dart';

abstract class ProfileRepository {
  Future<ApiResponse> updateProfile({
    required UserData user,
  });

  Future<ApiResponse> updateOrganizationProfile({
    required Organization organization,
  });

  Future<ApiResponse> getProfile({
    required String userId,
  });

  Future<ApiResponse> getOrganizationProfile({
    required String userId,
  });

  Future<ApiResponse> getProfileInfo({
    required String userId,
  });
}

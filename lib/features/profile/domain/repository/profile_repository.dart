import '../../../../services/api_reponse.dart';
import '../../../../core/models/user_data.dart';

abstract class ProfileRepository {
  Future<ApiResponse> updateProfile({
    required UserData user,
  });

  Future<ApiResponse> getProfile({
    required String userId,
  });
}

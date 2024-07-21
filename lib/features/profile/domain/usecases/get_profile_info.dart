import 'package:volunteer_linker/services/api_reponse.dart';

import '../repository/profile_repository.dart';

class GetProfileInfo {
  final ProfileRepository _profileRepository;

  GetProfileInfo(this._profileRepository);

  Future<ApiResponse> call(String userId) async {
    return await _profileRepository.getProfileInfo(
      userId: userId,
    );
  }
}

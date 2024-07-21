import 'package:volunteer_linker/services/api_reponse.dart';
import '../repository/profile_repository.dart';

class GetOrganizationProfileUsecase {
  final ProfileRepository repository;

  GetOrganizationProfileUsecase(
    this.repository,
  );

  Future<ApiResponse> call(
    String userId,
  ) async {
    return await repository.getOrganizationProfile(
      userId: userId,
    );
  }
}

import 'package:volunteer_linker/core/models/organization.dart';
import 'package:volunteer_linker/services/api_reponse.dart';
import '../repository/profile_repository.dart';

class UpdateOrganizationProfileUsecase {
  final ProfileRepository repository;

  UpdateOrganizationProfileUsecase(
    this.repository,
  );

  Future<ApiResponse> call(
    Organization organization,
  ) async {
    return await repository.updateOrganizationProfile(
      organization: organization,
    );
  }
}

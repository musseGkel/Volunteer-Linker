import 'package:volunteer_linker/services/api_reponse.dart';
import '../repository/profile_repository.dart';

class GetProfileUsecase {
  final ProfileRepository repository;

  GetProfileUsecase(
    this.repository,
  );

  Future<ApiResponse> call(
    String userId,
  ) async {
    return await repository.getProfile(
      userId: userId,
    );
  }
}

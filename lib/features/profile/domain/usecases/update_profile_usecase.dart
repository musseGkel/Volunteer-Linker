import 'package:volunteer_linker/services/api_reponse.dart';
import '../../../../core/models/user.dart';
import '../repository/profile_repository.dart';

class UpdateProfileUsecase {
  final ProfileRepository repository;

  UpdateProfileUsecase(
    this.repository,
  );

  Future<ApiResponse> call(
    UserData user,
  ) async {
    return await repository.updateProfile(
      user: user,
    );
  }
}

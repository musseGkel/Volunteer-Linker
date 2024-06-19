import 'package:either_dart/either.dart';

import '../../../../core/failure.dart';
import '../repository/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository _authRepository;

  LogoutUseCase(this._authRepository);

  Future<Either<Failure, bool>> call() async {
    return await _authRepository.logout();
  }
}

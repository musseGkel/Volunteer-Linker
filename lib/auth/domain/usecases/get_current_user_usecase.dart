import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:volunteer_linker/auth/core/failure.dart';
import 'package:volunteer_linker/auth/domain/repository/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository _authRepository;

  GetCurrentUserUseCase(this._authRepository);

  Future<Either<Failure, User?>> call() async {
    return await _authRepository.getCurrentUser();
  }
}

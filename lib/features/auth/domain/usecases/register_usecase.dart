import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/failure.dart';
import '../repository/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  Future<Either<Failure, User?>> call({
    required String email,
    required String password,
    required String name,
  }) async {
    return await _authRepository.register(
      email: email,
      password: password,
      name: name,
    );
  }
}

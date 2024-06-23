import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:volunteer_linker/core/enums.dart';

import '../../../../core/failure.dart';
import '../repository/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  Future<Either<Failure, User?>> call({
    required String email,
    required String password,
    required String name,
    required UserType userType,
  }) async {
    return await _authRepository.register(
      email: email,
      password: password,
      name: name,
      userType: userType,
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';

import '../repository/auth_repository.dart';

class ListenAuthStateChanges {
  final AuthRepository _authRepository;

  ListenAuthStateChanges(this._authRepository);

  Stream<User?> call() {
    return _authRepository.authStateChanges;
  }
}

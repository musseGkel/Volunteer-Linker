import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:volunteer_linker/auth/core/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, User?>> login(
      {required String email, required String password});
  Future<Either<Failure, User?>> register(
      {required String email, required String password});
  Future<Either<Failure, User?>> getCurrentUser();
  Future<Either<Failure, bool>> logout();
  Stream<User?> get authStateChanges;
}

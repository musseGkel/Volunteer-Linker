import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:volunteer_linker/core/enums.dart';

import '../../../../core/failure.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/auth_datasource.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource authDataSource;

  AuthRepositoryImpl({
    required this.authDataSource,
  });

  @override
  Future<Either<Failure, User?>> login({
    required String email,
    required String password,
  }) async {
    try {
      User? user = await authDataSource.login(
        email: email,
        password: password,
      );
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(
        Failure(
          message: e.message ?? '',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, User?>> register({
    required String email,
    required String password,
    required String name,
    required UserType userType,
  }) async {
    try {
      User? user = await authDataSource.register(
        email: email,
        password: password,
        name: name,
        userType: userType,
      );
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(
        Failure(
          message: e.message ?? '',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      await authDataSource.signOut();
      return const Right(true);
    } on FirebaseAuthException catch (e) {
      return Left(
        Failure(
          message: e.message ?? '',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final User? user = AuthDatasource().currentUser;
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(
        Failure(
          message: e.message ?? '',
        ),
      );
    }
  }

  @override
  Stream<User?> get authStateChanges => authDataSource.authStateChanges;
}

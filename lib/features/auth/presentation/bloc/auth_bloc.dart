import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/datasources/auth_datasource.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../../domain/usecases/listen_auth_state_changes_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    ListenAuthStateChanges(AuthRepositoryImpl(authDataSource: AuthDatasource()))
        .call()
        .listen((user) {
      add(
        AuthChangesEvent(user),
      );
    });
    on<AuthEvent>(
      (event, emit) async {
        await emit.forEach(
          event.handle(),
          onData: (state) {
            return state;
          },
        );
      },
    );
  }
}

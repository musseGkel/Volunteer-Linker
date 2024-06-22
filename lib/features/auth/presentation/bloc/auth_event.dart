part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  Stream<AuthState> handle();

  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({
    required this.email,
    required this.password,
  });

  @override
  Stream<AuthState> handle() async* {
    yield const AuthState(
      isLoading: true,
    );
    final result = await AuthRepositoryImpl(
      authDataSource: AuthDatasource(),
    ).login(
      email: email,
      password: password,
    );
    yield result.fold(
      (failure) => AuthState(errorMessage: failure.message),
      (success) => AuthState(
        user: success,
      ),
    );
  }
}

class LogoutEvent extends AuthEvent {
  const LogoutEvent();

  @override
  Stream<AuthState> handle() async* {
    yield const AuthState();
    final result = await AuthRepositoryImpl(
      authDataSource: AuthDatasource(),
    ).logout();
    yield result.fold(
      (failure) => AuthState(errorMessage: failure.message),
      (success) => const AuthState(),
    );
  }
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;
  final String name;

  const RegisterEvent({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.name,
  });

  @override
  Stream<AuthState> handle() async* {
    if (name.isEmpty) {
      yield const AuthState(
        errorMessage: 'Please fill all fields',
        isLogin: false,
      );
      return;
    }
    if (password != confirmPassword) {
      yield const AuthState(
        errorMessage: 'Password does not match',
        isLogin: false,
      );
      return;
    } else {
      yield const AuthState(
        isLoading: true,
        isLogin: false,
      );
      final result = await AuthRepositoryImpl(
        authDataSource: AuthDatasource(),
      ).register(
        email: email,
        password: password,
        name: name,
      );
      yield result.fold(
        (failure) => AuthState(
          errorMessage: failure.message,
          isLogin: false,
        ),
        (success) => AuthState(
          user: success,
          isLogin: false,
        ),
      );
    }
  }
}

class GetCurrentUserEvent extends AuthEvent {
  const GetCurrentUserEvent();

  @override
  Stream<AuthState> handle() async* {
    yield const AuthState();
    final result = await AuthRepositoryImpl(
      authDataSource: AuthDatasource(),
    ).getCurrentUser();
    yield result.fold(
      (failure) => AuthState(errorMessage: failure.message),
      (success) => AuthState(
        user: success,
      ),
    );
  }
}

class ToggleLoginEvent extends AuthEvent {
  final AuthState state;
  const ToggleLoginEvent(
    this.state,
  );

  @override
  Stream<AuthState> handle() async* {
    yield state.copyWith(
      isLogin: !state.isLogin,
    ) as AuthState;
  }
}

class AuthChangesEvent extends AuthEvent {
  final User? user;
  const AuthChangesEvent(
    this.user,
  );

  @override
  Stream<AuthState> handle() async* {
    yield AuthState(
      user: user,
    );
  }
}

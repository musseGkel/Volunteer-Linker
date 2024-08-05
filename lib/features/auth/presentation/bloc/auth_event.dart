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
        currentPage: CurrentPage.postOpportunity,
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

class ToggleUserType extends AuthEvent {
  final UserType userType;
  final AuthState state;

  const ToggleUserType({
    required this.userType,
    required this.state,
  });

  @override
  Stream<AuthState> handle() async* {
    AuthState updatedState = state.copyWith(
      userType: userType,
    );
    yield updatedState;
  }
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;
  final String name;
  final AuthState state;

  const RegisterEvent({
    required this.state,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.name,
  });

  @override
  Stream<AuthState> handle() async* {
    AuthState updatedState;
    if (name.isEmpty) {
      updatedState = state.copyWith(
        errorMessage: 'Please fill all fields',
        authMode: AuthMode.register,
      );
      yield updatedState;

      return;
    }
    if (password != confirmPassword) {
      updatedState = state.copyWith(
        errorMessage: 'Password does not match',
        authMode: AuthMode.register,
      );
      yield updatedState;
      return;
    } else {
      updatedState = state.copyWith(
        isLoading: true,
        authMode: AuthMode.register,
      );
      yield updatedState;

      final result = await AuthRepositoryImpl(
        authDataSource: AuthDatasource(),
      ).register(
        email: email,
        password: password,
        name: name,
        userType: state.userType,
      );
      yield result.fold(
        (failure) => AuthState(
          errorMessage: failure.message,
          authMode: AuthMode.register,
        ),
        (success) => AuthState(
          user: success,
          authMode: AuthMode.register,
          currentPage: CurrentPage.postOpportunity,
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
      authMode: state.isOnLogin() ? AuthMode.register : AuthMode.login,
    ) as AuthState;
  }
}

class AuthChangesEvent extends AuthEvent {
  final User? user;

  const AuthChangesEvent(this.user);

  @override
  Stream<AuthState> handle() async* {
    yield AuthState(
      user: user,
    );
  }
}

class ChangePageEvent extends AuthEvent {
  final CurrentPage changePage;
  final AuthState state;
  final String? opportunityId;

  const ChangePageEvent({
    required this.changePage,
    required this.state,
    this.opportunityId,
  });

  @override
  Stream<AuthState> handle() async* {
    print("ChangePageEvent $changePage");

    AuthState updatedState = state.copyWith(
      currentPage: changePage,
      selectedOpportunityId: opportunityId,
    );

    yield updatedState;
  }
}

class SelectOpportunityId extends AuthEvent {
  final String opportunityId;
  final AuthState state;
  const SelectOpportunityId({
    required this.opportunityId,
    required this.state,
  });

  @override
  Stream<AuthState> handle() async* {
    AuthState updatedState = state.copyWith(
      selectedOpportunityId: opportunityId,
    );
    yield updatedState;
  }
}

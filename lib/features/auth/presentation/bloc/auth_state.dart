part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final User? user;
  final String errorMessage;
  final bool isLoading;
  final AuthMode authMode;
  final UserType userType;

  const AuthState({
    this.userType = UserType.volunteer,
    this.user,
    this.errorMessage = '',
    this.isLoading = false,
    this.authMode = AuthMode.login,
  });

  @override
  List<Object> get props => [
        user ?? '',
        errorMessage,
        isLoading,
        authMode,
        userType,
      ];

  copyWith({
    User? user,
    String? errorMessage,
    bool? isLoading,
    AuthMode? authMode,
    UserType? userType,
  }) {
    return AuthState(
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      authMode: authMode ?? this.authMode,
      userType: userType ?? this.userType,
    );
  }

  bool isOnLogin() => authMode == AuthMode.login;
  bool isOnRegister() => authMode == AuthMode.register;
}

part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final User? user;
  final String errorMessage;
  final bool isLoading;
  final bool isLogin;

  const AuthState({
    this.user,
    this.errorMessage = '',
    this.isLoading = false,
    this.isLogin = true,
  });

  @override
  List<Object> get props => [
        user ?? '',
        errorMessage,
        isLoading,
        isLogin,
      ];

  copyWith({
    User? user,
    String? errorMessage,
    bool? isLoading,
    bool? isLogin,
  }) {
    return AuthState(
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      isLogin: isLogin ?? this.isLogin,
    );
  }
}

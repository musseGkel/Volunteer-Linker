part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final User? user;
  final String errorMessage;
  final bool isLoading;
  final AuthMode authMode;
  final UserType userType;
  final CurrentPage currentPage;
  final String selectedOpportunityId;
  final String selectedCompanyName;

  const AuthState({
    this.userType = UserType.volunteer,
    this.user,
    this.errorMessage = '',
    this.isLoading = false,
    this.authMode = AuthMode.login,
    this.currentPage = CurrentPage.home,
    this.selectedOpportunityId = "",
    this.selectedCompanyName = "",
  });

  @override
  List<Object> get props => [
        user ?? '',
        errorMessage,
        isLoading,
        authMode,
        userType,
        currentPage,
        selectedOpportunityId,
        selectedCompanyName,
      ];

  copyWith({
    User? user,
    String? errorMessage,
    bool? isLoading,
    AuthMode? authMode,
    UserType? userType,
    CurrentPage? currentPage,
    String? selectedOpportunityId,
    String? selectedCompanyName,
  }) {
    return AuthState(
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      authMode: authMode ?? this.authMode,
      userType: userType ?? this.userType,
      currentPage: currentPage ?? this.currentPage,
      selectedOpportunityId:
          selectedOpportunityId ?? this.selectedOpportunityId,
      selectedCompanyName: selectedCompanyName ?? this.selectedCompanyName,
    );
  }

  bool isOnLogin() => authMode == AuthMode.login;
  bool isOnRegister() => authMode == AuthMode.register;

  bool isCurrentPage(CurrentPage page) => currentPage == page;

  bool isUserType(UserType uType) {
    return userType == uType;
  }
}

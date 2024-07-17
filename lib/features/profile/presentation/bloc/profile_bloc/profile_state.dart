part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final bool editMode;
  final UserData? user;
  final String userId;
  final bool isLoading;

  const ProfileState({
    this.editMode = false,
    this.user,
    required this.userId,
    this.isLoading = false,
  });

  @override
  List<Object> get props => [editMode, userId, isLoading];

  copywith({
    bool? editMode,
    UserData? user,
    String? userId,
    bool? isLoading,
  }) {
    return ProfileState(
      editMode: editMode ?? this.editMode,
      user: user ?? this.user,
      userId: userId ?? this.userId,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

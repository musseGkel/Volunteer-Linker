part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final bool editMode;
  final UserData? user;
  final String userId;
  final bool isLoading;

  final String? tempName;
  final String? tempUsername;
  final String? tempEmail;
  final String? tempBio;
  final UserType? tempUserType;
  final String? tempProfilePictureUrl;
  final List<dynamic>? tempInterests;
  final List<dynamic>? tempSkills;
  final List<dynamic>? tempAvailability;
  final List<dynamic>? tempVolunteerActivities;

  const ProfileState({
    this.editMode = false,
    this.user,
    required this.userId,
    this.isLoading = false,
    this.tempName,
    this.tempUsername,
    this.tempEmail,
    this.tempBio,
    this.tempUserType,
    this.tempProfilePictureUrl,
    this.tempInterests,
    this.tempSkills,
    this.tempAvailability,
    this.tempVolunteerActivities,
  });

  @override
  List<Object> get props => [
        editMode,
        userId,
        isLoading,
      ];

  copywith({
    bool? editMode,
    UserData? user,
    String? userId,
    bool? isLoading,
    String? tempName,
    String? tempUsername,
    String? tempEmail,
    String? tempBio,
    UserType? tempUserType,
    String? tempProfilePictureUrl,
    List<dynamic>? tempInterests,
    List<dynamic>? tempSkills,
    List<dynamic>? tempAvailability,
    List<dynamic>? tempVolunteerActivities,
  }) {
    return ProfileState(
      editMode: editMode ?? this.editMode,
      user: user ?? this.user,
      userId: userId ?? this.userId,
      isLoading: isLoading ?? this.isLoading,
      tempName: tempName ?? this.tempName,
      tempUsername: tempUsername ?? this.tempUsername,
      tempEmail: tempEmail ?? this.tempEmail,
      tempBio: tempBio ?? this.tempBio,
      tempUserType: tempUserType ?? this.tempUserType,
      tempProfilePictureUrl:
          tempProfilePictureUrl ?? this.tempProfilePictureUrl,
      tempInterests: tempInterests ?? this.tempInterests,
      tempSkills: tempSkills ?? this.tempSkills,
      tempAvailability: tempAvailability ?? this.tempAvailability,
      tempVolunteerActivities:
          tempVolunteerActivities ?? this.tempVolunteerActivities,
    );
  }
}

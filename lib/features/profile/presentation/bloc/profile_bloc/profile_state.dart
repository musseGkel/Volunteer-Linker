part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final bool editMode;
  final UserData? user;
  final Organization? organization;
  final String userId;
  final bool isLoading;
  final String? tempName;
  final String? tempUsername;
  final String? tempEmail;
  final String? tempBio;
  final UserType? tempUserType;
  final String? tempProfilePictureUrl;
  final List<String>? tempInterests;
  final List<String>? tempSkills;
  final Map<String, List<TimeRange>>? tempAvailability;
  final List<String>? tempVolunteerActivities;
  final String? tempPhoneNumber;
  final String? tempAddress;
  final String? error;

  const ProfileState({
    this.editMode = false,
    this.user,
    this.organization,
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
    this.tempPhoneNumber = "",
    this.tempAddress,
    this.error,
  });

  @override
  List<Object> get props => [
        if (user != null) user!,
        if (organization != null) organization!,
        editMode,
        userId,
        isLoading,
        tempName ?? "",
        tempUsername ?? "",
        tempEmail ?? "",
        tempBio ?? "",
        tempUserType ?? UserType.volunteer,
        tempProfilePictureUrl ?? "",
        tempInterests ?? [],
        tempSkills ?? [],
        tempAvailability ?? {},
        tempVolunteerActivities ?? [],
        tempPhoneNumber ?? "",
        tempAddress ?? "",
        error ?? "",
      ];

  copywith({
    bool? editMode,
    UserData? user,
    Organization? organization,
    String? userId,
    bool? isLoading,
    String? tempName,
    String? tempUsername,
    String? tempEmail,
    String? tempBio,
    UserType? tempUserType,
    String? tempProfilePictureUrl,
    List<String>? tempInterests,
    List<String>? tempSkills,
    final Map<String, List<TimeRange>>? tempAvailability,
    List<String>? tempVolunteerActivities,
    String? tempPhoneNumber,
    String? tempAddress,
    String? error,
  }) {
    return ProfileState(
      editMode: editMode ?? this.editMode,
      user: user ?? this.user,
      organization: organization ?? this.organization,
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
      tempPhoneNumber: tempPhoneNumber ?? this.tempPhoneNumber,
      tempAddress: tempAddress ?? this.tempAddress,
      error: error ?? this.error,
    );
  }

  displayUserType() {
    if (tempUserType == UserType.volunteer) {
      return 'Volunteer';
    } else {
      return 'Organization';
    }
  }

  checkUserType(UserType userType) {
    if (tempUserType == userType) {
      return true;
    } else {
      return false;
    }
  }
}

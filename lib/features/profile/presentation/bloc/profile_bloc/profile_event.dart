part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();
  Stream<ProfileState> handle();

  @override
  List<Object> get props => [];
}

class ProfileEditModeChanged extends ProfileEvent {
  final ProfileState state;
  const ProfileEditModeChanged({
    required this.state,
  });

  @override
  List<Object> get props => [
        state,
      ];

  @override
  Stream<ProfileState> handle() async* {
    ProfileState updatedState = state.copywith(
      editMode: !state.editMode,
    );
    yield updatedState;
  }
}

class UpdateProfile extends ProfileEvent {
  final String id;
  final ProfileState state;

  const UpdateProfile({
    required this.state,
    required this.id,
  });

  @override
  Stream<ProfileState> handle() async* {
    ProfileState updateState = state.copywith(
      isLoading: true,
    );
    yield updateState;

    ApiResponse response = await ProfileRepositoryImpl(
      datasource: ProfileDatasource(),
    ).updateProfile(
      user: UserData(
        id: id,
        name: state.tempName ?? "",
        email: state.tempEmail ?? "",
        username: state.tempUsername ?? "",
        bio: state.tempBio ?? "",
        userType: state.user?.userType ?? UserType.volunteer,
        profilePictureUrl: state.user?.profilePictureUrl ?? "",
        interests: state.tempInterests ?? [],
        skills: state.tempSkills ?? [],
        availability: state.tempAvailability ?? {},
        volunteerActivities: state.tempVolunteerActivities ?? [],
        phoneNumber: state.tempPhoneNumber ?? "",
      ),
    );

    if (response.statusCode != 200) {
      updateState = state.copywith(
        isLoading: false,
      );
      yield updateState;
      return;
    } else {
      updateState = state.copywith(
        isLoading: false,
        editMode: false,
      );

      yield updateState;
    }
  }
}

class GetProfile extends ProfileEvent {
  final ProfileState state;

  const GetProfile({
    required this.state,
  });

  @override
  Stream<ProfileState> handle() async* {
    ProfileState updateState = state.copywith(
      isLoading: true,
    );
    yield updateState;
    ApiResponse response = await ProfileRepositoryImpl(
      datasource: ProfileDatasource(),
    ).getProfile(
      userId: state.userId,
    );

    if (response.statusCode != 200) {
      updateState = state.copywith(
        isLoading: false,
      );
      yield updateState;
      return;
    } else {
      updateState = state.copywith(
        user: response.body as UserData,
        isLoading: false,
        tempName: response.body.name,
        tempUsername: response.body.username,
        tempEmail: response.body.email,
        tempBio: response.body.bio,
        tempSkills: response.body.skills,
        tempInterests: response.body.interests,
        tempAvailability: response.body.availability,
        tempVolunteerActivities: response.body.volunteerActivities,
        tempPhoneNumber: response.body.phoneNumber,
        tempProfilePictureUrl: response.body.profilePictureUrl,
      );

      yield updateState;
    }
  }
}

class UpdateTempName extends ProfileEvent {
  final String name;
  final ProfileState state;

  const UpdateTempName({
    required this.state,
    required this.name,
  });

  @override
  Stream<ProfileState> handle() async* {
    ProfileState updateState = state.copywith(
      tempName: name,
    );
    yield updateState;
  }
}

class UpdateTempUsername extends ProfileEvent {
  final String username;
  final ProfileState state;

  const UpdateTempUsername({
    required this.state,
    required this.username,
  });

  @override
  Stream<ProfileState> handle() async* {
    ProfileState updateState = state.copywith(
      tempUsername: username,
    );
    yield updateState;
  }
}

class UpdateTempEmail extends ProfileEvent {
  final String email;
  final ProfileState state;

  const UpdateTempEmail({
    required this.state,
    required this.email,
  });

  @override
  Stream<ProfileState> handle() async* {
    ProfileState updateState = state.copywith(
      tempEmail: email,
    );
    yield updateState;
  }
}

class UpdateTempBio extends ProfileEvent {
  final String bio;
  final ProfileState state;

  const UpdateTempBio({
    required this.state,
    required this.bio,
  });

  @override
  Stream<ProfileState> handle() async* {
    ProfileState updateState = state.copywith(
      tempBio: bio,
    );
    yield updateState;
  }
}

class UpdatePhoneNumber extends ProfileEvent {
  final String phoneNumber;
  final ProfileState state;

  const UpdatePhoneNumber({
    required this.state,
    required this.phoneNumber,
  });

  @override
  Stream<ProfileState> handle() async* {
    ProfileState updateState = state.copywith(
      tempPhoneNumber: phoneNumber,
    );
    yield updateState;
  }
}

class UpdateSkills extends ProfileEvent {
  final List<String> skills;
  final ProfileState state;

  const UpdateSkills({
    required this.state,
    required this.skills,
  });

  @override
  Stream<ProfileState> handle() async* {
    ProfileState updateState = state.copywith(
      tempSkills: skills,
    );
    yield updateState;
  }
}

class UpdateAvailability extends ProfileEvent {
  final Map<String, List<TimeRange>> availability;
  final ProfileState state;

  const UpdateAvailability({
    required this.state,
    required this.availability,
  });

  @override
  Stream<ProfileState> handle() async* {
    ProfileState updateState = state.copywith(
      tempAvailability: availability,
    );
    yield updateState;
  }
}

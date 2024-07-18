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
  final String name;
  final String email;
  final String username;
  final String? bio;
  final UserType userType;
  final String? profilePictureUrl;
  final List<String> interests;
  final List<String> skills;
  final List<String> availability;
  final List<String> volunteerActivities;
  final ProfileState state;

  const UpdateProfile({
    required this.state,
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    this.bio,
    required this.userType,
    this.profilePictureUrl,
    this.interests = const [],
    this.skills = const [],
    this.availability = const [],
    this.volunteerActivities = const [],
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
        name: name,
        email: email,
        username: username,
        bio: bio ?? "",
        userType: userType,
        profilePictureUrl: profilePictureUrl ?? "",
        interests: interests,
        skills: skills,
        availability: availability,
        volunteerActivities: volunteerActivities,
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
